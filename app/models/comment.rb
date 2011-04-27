class Comment < ActiveRecord::Base
    attr_accessible :commentable_type, :commentable_id, :content
    belongs_to :commentable, :polymorphic => true
end
