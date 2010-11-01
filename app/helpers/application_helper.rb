#encoding: utf-8

module ApplicationHelper
  def title head_title
    content_for :head do
      head_title
    end
  end

  def flash_helper
    if flash[:notice]
      content_tag :p, flash[:notice], :class => 'notice'
    end
  end
end
