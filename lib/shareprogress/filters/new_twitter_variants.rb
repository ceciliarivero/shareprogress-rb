class NewTwitterVariants < Scrivener
  attr_accessor :twitter, :button_template

  def validate
    assert_member :button_template, %w{sp_tw_small sp_tw_large}

    if assert_present :twitter
      twitter.each do |t|

        if assert !t["twitter_message"].nil?, [:twitter_message, :nil]

          if assert !t["twitter_message"].empty?, [:twitter_message, :empty]
            assert t["twitter_message"].include?("{LINK}"), [:twitter_message, :link_not_included]
          end

        end

      end
    end
  end
end
