defmodule Freelixir do
  @url "https://smsapi.free-mobile.fr/sendmsg"

  def send_sms(user: user, password: password, message: message)
  when is_bitstring(user)
  when is_bitstring(password)
  when is_bitstring(message)
  do
    "#{@url}?user=#{user}&password=#{password}&msg=#{message}"
      |> HTTPoison.get
      |> check_status
  end

  def send_sms(user: _user, password: _password, message: _message) do
    {:error, %{message: "Freelixir only accept string params"}}
  end

  defp check_status({:ok, res}) do
    case res.status_code do
      200 ->
        {:ok, "SMS was sent successfully"}
      400 ->
        {:error, %{code: 400, message: "Parameters missing: user, password and msg are required"}}
      402 ->
        {:error, %{code: 402, message: "To many SMS has been sent, wait few minutes"}}
      403 ->
        {:error, %{code: 403, message: "You didn't activate the service « Notifications par SMS »"}}
      _code ->
        {:error, %{code: 500, message: "An error occurred with Free Mobile service"}}
    end
  end

  defp check_status({_, res}) do
    {:error, %{message: res.reason.message}}
  end

end
