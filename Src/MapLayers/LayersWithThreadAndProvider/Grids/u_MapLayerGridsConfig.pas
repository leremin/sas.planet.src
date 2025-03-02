{******************************************************************************}
{* This file is part of SAS.Planet project.                                   *}
{*                                                                            *}
{* Copyright (C) 2007-2021, SAS.Planet development team.                      *}
{*                                                                            *}
{* SAS.Planet is free software: you can redistribute it and/or modify         *}
{* it under the terms of the GNU General Public License as published by       *}
{* the Free Software Foundation, either version 3 of the License, or          *}
{* (at your option) any later version.                                        *}
{*                                                                            *}
{* SAS.Planet is distributed in the hope that it will be useful,              *}
{* but WITHOUT ANY WARRANTY; without even the implied warranty of             *}
{* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the               *}
{* GNU General Public License for more details.                               *}
{*                                                                            *}
{* You should have received a copy of the GNU General Public License          *}
{* along with SAS.Planet. If not, see <http://www.gnu.org/licenses/>.         *}
{*                                                                            *}
{* https://github.com/sasgis/sas.planet.src                                   *}
{******************************************************************************}

unit u_MapLayerGridsConfig;

interface

uses
  i_MapLayerGridsConfig,
  i_ThreadConfig,
  u_ConfigDataElementComplexBase;

type
  TMapLayerGridsConfig = class(TConfigDataElementComplexBase, IMapLayerGridsConfig)
  private
    FTileGrid: ITileGridConfig;
    FGenShtabGrid: IGenShtabGridConfig;
    FDegreeGrid: IDegreeGridConfig;
    FThreadConfig: IThreadConfig;
  private
    function GetTileGrid: ITileGridConfig;
    function GetGenShtabGrid: IGenShtabGridConfig;
    function GetDegreeGrid: IDegreeGridConfig;
    function GetThreadConfig: IThreadConfig;
  public
    constructor Create;
  end;

implementation

uses
  Classes,
  u_ConfigSaveLoadStrategyBasicProviderSubItem,
  u_ThreadConfig,
  u_TileGridConfig,
  u_GenShtabGridConfig,
  u_DegreeGridConfig;

{ TMapLayerGridsConfig }

constructor TMapLayerGridsConfig.Create;
begin
  inherited Create;
  FTileGrid := TTileGridConfig.Create;
  Add(FTileGrid, TConfigSaveLoadStrategyBasicProviderSubItem.Create('TileGrid'));
  FGenShtabGrid := TGenShtabGridConfig.Create;
  Add(FGenShtabGrid, TConfigSaveLoadStrategyBasicProviderSubItem.Create('GenShtabGrid'));
  FDegreeGrid := TDegreeGridConfig.Create;
  Add(FDegreeGrid, TConfigSaveLoadStrategyBasicProviderSubItem.Create('DegreeGrid'));
  FThreadConfig := TThreadConfig.Create(tpNormal);
  Add(FThreadConfig, TConfigSaveLoadStrategyBasicProviderSubItem.Create('Grids'));
end;

function TMapLayerGridsConfig.GetGenShtabGrid: IGenShtabGridConfig;
begin
  Result := FGenShtabGrid;
end;

function TMapLayerGridsConfig.GetDegreeGrid: IDegreeGridConfig;
begin
  Result := FDegreeGrid;
end;

function TMapLayerGridsConfig.GetThreadConfig: IThreadConfig;
begin
  Result := FThreadConfig;
end;

function TMapLayerGridsConfig.GetTileGrid: ITileGridConfig;
begin
  Result := FTileGrid;
end;

end.
