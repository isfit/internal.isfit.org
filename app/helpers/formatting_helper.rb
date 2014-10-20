module FormattingHelper
  def formatting
    formatting = content_tag :p do
      content_tag( :button, "Formatting", class: "btn btn-info", data: {"toggle" => "modal", "target" => "#formatting", backdrop: "true", keyboard: "true" }).html_safe
    end
    formatting += content_tag :div, id: "formatting", class: "modal fade", tabIndex: "-1", role: "dialog",
    :"aria-labelledby" => "Formatting", :"aria-hidden" => "true"  do
      modal = content_tag :div, class: "modal-dialog" do
        content_tag :div, class: "modal-content" do
          modal_body = content_tag :div, class: "modal-header" do
            link_to :x, "#", class: "close"
            content_tag :h3, "Formatting"
          end
          modal_body += content_tag :div, class: "modal-body" do
            content_tag :table, class: "table table-bordered" do
              table = content_tag :tr, content_tag(:th, "Markdown") + content_tag(:th, "HTML")
              table += content_tag :tr, content_tag(:td, "###Heading") + content_tag(:td, content_tag(:h3, "Heading"))
              table += content_tag :tr, content_tag(:td, "####Sub-heading") + content_tag(:td, content_tag(:h4, "Sub-heading"))
              table += content_tag :tr, content_tag(:td, "*emphasized text*") + content_tag(:td, content_tag(:em, "emphasized text"))
              table += content_tag :tr, content_tag(:td, "**emphasized text**") + content_tag(:td, content_tag(:strong, "emphasized text"))
              table += content_tag :tr, content_tag(:td, "- Item 1#{tag(:br)}- Item 2 #{tag(:br)}- Item 3".html_safe, escape: false) + content_tag(:td, content_tag(:ul, content_tag(:li, "Item 1") + content_tag(:li, "Item 2") + content_tag(:li, "Item 3")))
              table += content_tag :tr, content_tag(:td, "[ISFiT](http://isfit.org)") + content_tag(:td, link_to("ISFiT", "http://isfit.org"))
              table += content_tag :tr, content_tag(:td, "##yt 2Tjb14VoWjg yt##") + content_tag(:td, "Embeds a youtube video into the webpage.")
            end
          end
          modal_body += content_tag :div, class: "modal-footer" do
            link_to "Markdown documentation", "http://daringfireball.net/projects/markdown/"
          end
        end
      end
      modal
    end
    return formatting
  end
end
