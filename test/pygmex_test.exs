defmodule PygmexTest do
  use ExUnit.Case

  @source "Enum.each([1, 2], &(&1 * 2))"
  @expected "<table class=\"highlighttable\"><tr><td class=\"linenos\"><div class=\"linenodiv\"><pre>1</pre></div></td><td class=\"code\"><div class=\"highlight\"><pre><span class=\"no\">Enum</span><span class=\"o\">.</span><span class=\"n\">each</span><span class=\"p\">([</span><span class=\"m\">1</span><span class=\"p\">,</span> <span class=\"m\">2</span><span class=\"p\">],</span> <span class=\"err\">&amp;</span><span class=\"p\">(</span><span class=\"nv\">&amp;1</span> <span class=\"o\">*</span> <span class=\"m\">2</span><span class=\"p\">))</span>\n</pre></div>\n</td></tr></table>"

  test "it highlights code" do
    options = [linenos: 1]
    assert @expected == Pygmex.highlight(@source, :elixir, options)
  end
end
