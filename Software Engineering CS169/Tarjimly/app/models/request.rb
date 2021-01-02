class Request < ApplicationRecord
    has_many :claims, dependent: :nullify
end
