defmodule Rockelivery.Error do
  @keys [:status, :result]

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end
end
