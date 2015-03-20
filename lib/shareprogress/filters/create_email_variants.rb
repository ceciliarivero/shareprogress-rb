class CreateEmailVariants < Scrivener
  attr_accessor :email, :button_template

  def validate
    assert_member :button_template, %w{sp_em_small sp_em_large}

    if assert_present :email
      email.each do |e|

        if assert !e["email_subject"].nil?, [:email_subject, :nil]
          assert !e["email_subject"].empty?, [:email_subject, :empty]
        end

        if assert !e["email_body"].nil?, [:email_body, :nil]

          if assert !e["email_body"].empty?, [:email_body, :empty]
            assert e["email_body"].include?("{LINK}"), [:email_body, :link_not_included]
          end

        end

      end
    end

  end
end
