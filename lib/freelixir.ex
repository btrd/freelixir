defmodule Freelixir do

  def send_sms(user: user, password: password, message: message) do
    url = "https://smsapi.free-mobile.fr/sendmsg"
    cond do
      String.valid?(user) && String.valid?(password) && String.valid?(message) ->
        HTTPoison.get("#{url}?user=#{user}&password=#{password}&msg=#{message}") |> check_status
      true ->
        {:error, "Freelixir only accept string parans"}
    end
  end

  def check_status(params) do
    cond do
      {:ok, res} = params ->
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
      {_, res} = params ->
        {:error, res}
    end
  end

end
