class FacebookerPublisher < Facebooker::Rails::Publisher
  
  def posted_action(facebook_user, stream)
    FacebookerPublisher::FacebookTemplate.bundle_id_for_class_and_method(FacebookerPublisher, 'posted_action') or FacebookerPublisher.register_posted_action

    stream_name =
      if stream.name.to_s.blank?
        ''
      else
        %(: "#{truncate(stream.name, 10)}")
      end

    
    send_as :user_action
    from facebook_user
    data :stream_name => stream_name
  end

  def posted_action_template
    one_line_story_template "{*actor*} just posted a listing {*stream_name*} using FB Test"
    short_story_template    "{*actor*} just posted a listing {*stream_name*} using FB Test",
                            "{*stream_name*} listing"
  end
  
end
