defmodule SaucerPreflight do
  @moduledoc """
  Utilities for preflight
  """
  defp max_flying_load_lbs, do: 55
  defp convert_kg_lb(kg_value), do: kg_value * 2.2

  @doc """
  Calculate total weight in pounds for a list of Equipement

  ## Examples
    iex> SaucerPreflight.calculate_total_weight_in_pounds(EquipmentDetails.get_equipment_list())
    90.2
  """
  def calculate_total_weight_in_pounds([]), do: 0
  def calculate_total_weight_in_pounds([head | tail]) do
    # (head |> EquipmentDetails.item_details() |> elem(0) |> convert_kg_lb()) + calculate_total_weight_in_pounds(tail)
    # (EquipmentDetails.item_details(head) |> (fn (details) -> elem(details, 0) * elem(details, 2) end).() |> convert_kg_lb) + calculate_total_weight_in_pounds(tail)
    (EquipmentDetails.item_details(head) |> (&(elem(&1, 0) * elem(&1, 2))).() |> convert_kg_lb) +
      calculate_total_weight_in_pounds(tail)
  end

  @doc """
  ## Examples
    iex> SaucerPreflight.is_under_max_load?(EquipmentDetails.get_equipment_list())
    false
  """
  def is_under_max_load?(list) do
    if calculate_total_weight_in_pounds(list) > max_flying_load_lbs(), do: false, else: true
  end
end
