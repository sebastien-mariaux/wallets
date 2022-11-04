# frozen_string_literal: true

module ApplicationHelper
  def icon_link_to(text, icon, url)
    link_to url, class: 'btn btn-info btn-sm icon-link-to',
                 data: { 'bs-toggle' => 'tooltip', 'bs-placement' => 'top' }, title: text do
      icon_link_content(icon, text)
    end
  end

  def icon_link_content(icon, text)
    content = tag.i(class: icon)
    return content if text.blank?

    content + tag.span(class: 'icon-button-text') { text }
  end

  def model_t(model_name)
    t("activerecord.models.#{model_name}.one")
  end
end
