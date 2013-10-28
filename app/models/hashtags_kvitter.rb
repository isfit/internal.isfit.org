class HashtagsKvitter < ActiveRecord::Base
	has_one :kvitters
	has_one :hashtag
end