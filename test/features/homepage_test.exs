defmodule HomepageTest do
  use ExUnit.Case
  use Hound.Helpers
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Hound.Element

  hound_session()

  test "displays the navbar" do
    use_cassette "displays_the_navbar" do
      navigate_to("/")
      assert(String.contains? visible_page_text(), "Total market cap")
      assert(String.contains? visible_page_text(), "24 hour volume")
      assert(String.contains? visible_page_text(), "Bitcoin dominance")
      assert(String.contains? visible_page_text(), "Active tokens")
      assert Element.element?(find_element(:class, "fa-github"))
      assert Element.element?(find_element(:class, "fa-linkedin-square"))
    end
  end
end
