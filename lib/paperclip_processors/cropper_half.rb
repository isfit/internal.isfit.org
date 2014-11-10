module Paperclip
  class CropperHalf < Thumbnail
    def transformation_command
      if crop_command
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
        # super returns an array like this: ["-resize", "100x", "-crop", "100x100+0+0", "+repage"]
      else
        super
      end
    end

    def crop_command
      target = @attachment.instance
      if target.cropping?
        ["-crop", "#{target.x2_1.to_i-target.x1_1.to_i}x#{target.y2_1.to_i-target.y1_1.to_i}+#{target.x1_1}+#{target.y1_1}"]
      end
    end
  end
end

