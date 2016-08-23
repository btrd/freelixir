defmodule FreelixirTest do
  use ExUnit.Case
  doctest Freelixir

  test "send_sms: reject 3 non string arguments" do
    assert {:error, _} = Freelixir.send_sms(user: 11634714, password: 234, message: "Hello World !")
  end

  test "send_sms: accept 3 string arguments" do
    assert {:ok, _} = Freelixir.send_sms(user: "11634714", password: "jTKWtfXEFwB3Er", message: "Hello World !")
  end

end
