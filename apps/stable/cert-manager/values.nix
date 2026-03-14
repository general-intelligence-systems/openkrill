# No values.schema.json available for this chart.
# All values are passed through without type checking.
{ lib, ... }:
{
  freeformType = lib.types.attrsOf lib.types.anything;
}
