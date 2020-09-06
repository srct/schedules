module ApplicationHelper
  def sort_seasons(seasons)
    # Sort by Spring < Summer < Fall
    seasons.sort do |s1, s2|
      case
      when s1 == "Fall"
        -1
      when s1 == "Summer" && s2 == "Fall"
        1
      when s1 == "Spring"
        1
      else
        0
      end
    end
  end
end
