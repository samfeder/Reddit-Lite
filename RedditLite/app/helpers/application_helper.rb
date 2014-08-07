module ApplicationHelper

  def form_errors
    return unless flash.now[:errors]
    html = ""
    flash.now[:errors].each do |error|
      html += error + "<br>"
    end

    html
  end

  def auth_token
    <<-HTML.html_safe
    <input
      type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}">
    HTML
  end
end
