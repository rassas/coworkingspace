class Request < ApplicationRecord
  belongs_to :coworking_space

  validates_presence_of :phone, :email, :biography, :name, message: :blank

  enum status: {
    unconfirmed: 0,
    confirmed: 1,
    accepted: 2,
    expired: 3
  }

  before_create :generate_confirmation_token
  after_create :send_confirmation_instructions

  # Generates a new random token for confirmation
  def generate_confirmation_token
    unless self.confirmation_token
      self.confirmation_token = generate_unique_secure_confirmation_token()
      self.confirmation_sent_at = Time.now.utc
    end
  end

  def generate_unique_secure_confirmation_token
    10.times do |i|
      SecureRandom.hex(12).tap do |token|
        if Request.find_by(confirmation_token: token) && i == 9
          raise "Couldn't generate a unique token in 10 attempts!"
        else
          return token
        end
      end
    end
  end

  def generate_confirmation_token!
    generate_confirmation_token && save(validate: false)
  end

  # Send confirmation instructions by email
  def send_confirmation_instructions
    ConfirmationMailer.confirmation_instructions(self).deliver
  end

  # Confirm a request by setting it's confirmed_at to actual time.
  # If the request is already confirmed, add an error to email field.
  def confirm!
    unless !!confirmed_at
      update(confirmed_at: Time.now.utc, status: :confirmed)
    else
      errors.add(:email, :already_confirmed)
    end
  end

  def self.confirm_by_token(confirmation_token)
    if confirmation_token.blank?
      request = new
      request.errors.add(:confirmation_token, :blank)
      return request
    end

    request = find_by(confirmation_token: confirmation_token)
    request.confirm! if request.persisted?
    request
  end

  def self.resend_confirmation_instructions(email)
    if email.blank?
      request = new
      request.errors.add(:email, :blank)
      return request
    end

    request = find_by(email: email)
    if request.nil?
      request = new
      request.errors.add(:email, :not_found)
    elsif request.confirmed_at.nil?
      request.send_confirmation_instructions
    else
      request.errors.add(:email, :already_confirmed)
    end
    request
  end

  def accept!
    if unconfirmed? && !!!confirmed_at
      errors.add(:email, :not_confirmed)
    elsif CoworkingSpace.last.workstations_limit <= Request.accepted.count
      errors[:base] << I18n.t("errors.coworking_space_has_reached_it_limit")
    else
      update(status: :accepted, accepted_at: Time.now.utc)
    end
  end
end
