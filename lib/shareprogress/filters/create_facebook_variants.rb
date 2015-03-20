class CreateFacebookVariants < Scrivener
  attr_accessor :facebook, :button_template

  def validate
    assert_member :button_template, %w{sp_fb_small sp_fb_large}

    if assert_present :facebook
      facebook.each do |f|

        if assert !f["facebook_title"].nil?, [:facebook_title, :nil]
          assert !f["facebook_title"].empty?, [:facebook_title, :empty]
        end

        if assert !f["facebook_description"].nil?, [:facebook_description, :nil]
          assert !f["facebook_description"].empty?, [:facebook_description, :empty]
        end

        if assert !f["facebook_thumbnail"].nil?, [:facebook_thumbnail, :nil]
          assert !f["facebook_thumbnail"].empty?, [:facebook_thumbnail, :empty]
        end

      end
    end
  end
end
