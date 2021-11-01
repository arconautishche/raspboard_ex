defmodule Hue.Client do

  @bridge_ip "192.168.0.162"
  @bridge_username "50zOzkeglqmhMTzLEbmzvhHkGyydHB2Nl4o6JLsr"

  def get_lights do
    url = "http://#{@bridge_ip}/api/#{@bridge_username}/lights"
    case HTTPoison.get url  do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok,
        body
        |> Jason.decode!([keys: :atoms])
        |> Enum.map(&mapToHueLight/1)}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, 'Failed with status code #{status_code}'}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      _ ->
        {:error, :unknown}
    end
  end

  @spec set_light(any, any) :: {:error} | {:ok}
  def set_light(light_id, desired_state) do
    url = "http://#{@bridge_ip}/api/#{@bridge_username}/lights/#{light_id}/state"
    body = %{on: desired_state} |> Jason.encode!()

    case HTTPoison.put(url, body) do
      {:ok, %{status_code: 200}} -> {:ok}
      _ -> {:error}
    end
  end

  defp mapToHueLight({ id, details }) do
    %Hue.Light{
      id: Atom.to_string(id),
      name: details.name,
      state: details.state
    }
  end

end
