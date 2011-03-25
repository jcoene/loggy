class Unit < ActiveRecord::Base
		attr_reader :name, :guid, :flags

		def to_i; self.id; end
		def to_s; @name || "Nobody"; end

		def initialize(name, guid, flags)
			@name, @guid, @flags, = name, guid, flags
			@name = "Nobody" if @name == "nil"
		end

		def id; self.npc? ? @guid[8..11].to_i(16) : 0; end

		def exists?; not @guid == UNIT_GUID_NONE; end
		def player?; (@flags & OBJECT_TYPE_MASK) == OBJECT_TYPE_PLAYER; end
		def pet?; (@flags & OBJECT_TYPE_MASK) == OBJECT_TYPE_PET; end
		def npc?; (@flags & OBJECT_TYPE_MASK) == OBJECT_TYPE_NPC; end
		def friendly?; (@flags & OBJECT_REACTION_MASK) == OBJECT_REACTION_FRIENDLY; end
		def hostile?; (@flags & OBJECT_REACTION_MASK) == OBJECT_REACTION_HOSTILE; end
		def neutral?; (@flags & OBJECT_REACTION_MASK) == OBJECT_REACTION_FRIENDLY; end

end
