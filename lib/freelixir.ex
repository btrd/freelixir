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

end
