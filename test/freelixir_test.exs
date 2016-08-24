defmodule FreelixirTest do
  use ExUnit.Case
  doctest Freelixir

  test "send_sms: reject 3 non string arguments" do
    assert {:error, _} = Freelixir.send_sms(user: 11634714, password: 234, message: "Hello World !")
  end

  test "send_sms: reject false creditial" do
    assert {:error, _} = Freelixir.send_sms(user: "11634714", password: "jTKWtfXEFwB3Er", message: "Hello World !")
  end

  test "check_status: reply error if params not ok" do
    assert {:error, _} = Freelixir.check_status({:error, "Error"})
  end

  test "check_status: reply error if params :ok but status unknown" do
    assert {:error, _} = Freelixir.check_status({:ok, %{status_code: 999}})
  end

  test "check_status: reply ok if params :ok and status 200" do
    assert {:ok, _} = Freelixir.check_status({:ok, %{status_code: 200}})
  end

end
