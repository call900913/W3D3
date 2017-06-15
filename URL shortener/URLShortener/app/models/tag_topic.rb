class TagTopic < ApplicationRecord


def self.create_instance(str)
  TagTopic.create! topic: str
end



  has_many :urls_with_tag,
    through: :taggings,
    source: :url

  has_many :taggings,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :Tagging
end
