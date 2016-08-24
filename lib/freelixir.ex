defmodule Freelixir do

  def send_sms(user: user, password: password, message: message) do
    url = "https://smsapi.free-mobile.fr/sendmsg"
    cond do
      String.valid?(user) && String.valid?(password) && String.valid?(message) ->
        "#{url}?user=#{user}&password=#{password}&msg=#{message}"
        |> HTTPoison.get
        |> check_status
      true ->
        {:error, "Freelixir only accept string params"}
    end
  end

  def check_status({:ok, res}) do
    case res.status_code do
      200 ->
        {:ok, "SMS was sent successfully"}
      400 ->
        {:error, "Parameters missing: user, password and msg are required"}
      402 ->
        {:error, "To many SMS has been sent, wait few minutes"}
      403 ->
        {:error, "You didn't activate the service « Notifications par SMS »"}
      _   ->
        {:error, "An error occurred with Free Mobile service"}
    end
  end

  def check_status({_, res}) do
    {:error, res}
  end

end
