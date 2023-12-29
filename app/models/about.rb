class About < ApplicationRecord
    belongs_to :user
  
    attribute :topics, default: 'No topics listed yet'
    attribute :interests, default: 'No interests added yet'
    attribute :languages, default: 'No languages added yet'
    attribute :links, default: 'No links to their work yet'
  end
  