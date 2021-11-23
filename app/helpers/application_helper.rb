# frozen_string_literal: true

module ApplicationHelper
  def icon_link_to(text, icon, url)
    link_to  url, class: "btn btn-info btn-sm",
                       data: {'bs-toggle' => "tooltip","bs-placement"=>"top"}, title: text do
      tag.i(class: icon)
    end
  end
end
