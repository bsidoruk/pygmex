defmodule Pygmex do

  @moduledoc """
  Syntax highlighting via Pygments.
  """

  @doc """
  Returns html for the given source, lexer and options.
  """
  @spec highlight(binary, atom, Keyword.t) :: binary
  def highlight(source, opts \\ []) do
    highlight(source, :text, opts)
  end
  def highlight(source, lexer, opts) do
    opts = [lexer_option(lexer), make_options(opts), tmp_file(source)] |> List.flatten
    {content, _} = System.cmd pygmentize, opts, into: ""

    content.present? ? content : source
  end

  defp lexer_option(lexer), do: ["-l", Atom.to_string(lexer), "-f", "html"]

  defp make_options(opts \\ []) do
    Enum.map(opts, fn({k, v}) -> ["-O", "#{k}=#{v}"] end)
  end

  defp tmp_dir do
    tmp_dir = Path.expand("../priv/tmp", Path.dirname(__ENV__.file))
    File.mkdir(tmp_dir)

    tmp_dir
  end

  defp tmp_file(source) do
    file = "#{tmp_dir}/#{:crypto.hash(:md5, source) |> Base.encode16}"
    case File.write!(file, source) do
      :ok ->
        File.close(file)
        file
      {:error, reason} ->
        throw reason
    end
  end

  defp pygmentize do
    case System.find_executable("python") do
      nil ->
        throw "python binary could not be found."
      _ ->
        Path.expand("../priv/pygments/pygmentize", Path.dirname(__ENV__.file))
    end
  end
end
