module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.chefname, class: "rounded-circle")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).build_association({})
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "javascript:void(0);", "data-association": association.to_s, "data-content": fields.to_s, id: "add-ingredient")
  end

  def min_password_placeholder min_password_length
    " (#{min_password_length} characters minimum)"
  end
end
