class Users::Admin < User
  has_many :invitees, class_name: "User", foreign_key: "invited_by_id"
end