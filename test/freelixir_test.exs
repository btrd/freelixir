defmodule FreelixirTest do
  use ExUnit.Case
  doctest Freelixir

  import Mock

  test "send_sms: reject 3 non string arguments" do
    assert {:error, _} = Freelixir.send_sms(user: 11634714, password: 234, message: "Hello World !")
  end

  test_with_mock "send_sms: on succes", HTTPoison,
    [get: fn(_url) -> {:ok, %{status_code: 200}} end] do
    assert {:ok, _msg} = Freelixir.send_sms(user: "_user_", password: "_password_", message: "Hello World !")
  end

  test_with_mock "send_sms: reject missing argument", HTTPoison,
    [get: fn(_url) -> {:ok, %{status_code: 400}} end] do
    assert {:error, %{code: 400, message: _}} = Freelixir.send_sms(user: "_user_", password: "_password_", message: "Hello World !")
  end

  test_with_mock "send_sms: reject too many calls to Free Mobile API", HTTPoison,
    [get: fn(_url) -> {:ok, %{status_code: 402}} end] do
    assert {:error, %{code: 402, message: _}} = Freelixir.send_sms(user: "_user_", password: "_password_", message: "Hello World !")
  end

  test_with_mock "send_sms: reject false credential", HTTPoison,
    [get: fn(_url) -> {:ok, %{status_code: 403}} end] do
    assert {:error, %{code: 403, message: _}} = Freelixir.send_sms(user: "_user_", password: "_fake_password_", message: "Hello World !")
  end

  test_with_mock "send_sms: error at Free Mobile API", HTTPoison,
    [get: fn(_url) -> {:ok, %{status_code: 500}} end] do
    assert {:error, %{code: 500, message: _}} = Freelixir.send_sms(user: "_user_", password: "_password_", message: "Hello World !")
  end

end
