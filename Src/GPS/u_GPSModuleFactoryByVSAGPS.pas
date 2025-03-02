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

unit u_GPSModuleFactoryByVSAGPS;

interface

uses
  i_GPSPositionFactory,
  i_SystemTimeProvider,
  i_GPSModuleByCOM,
  i_GPSModuleByCOMFactory,
  u_BaseInterfacedObject;

type
  TGPSModuleFactoryByVSAGPS = class(TBaseInterfacedObject, IGPSModuleByCOMFactory)
  private
    FSystemTime: ISystemTimeProvider;
    FGPSPositionFactory: IGPSPositionFactory;
  private
    function CreateGPSModule: IGPSModuleByCOM;
  public
    constructor Create(
      const ASystemTime: ISystemTimeProvider;
      const AGPSPositionFactory: IGPSPositionFactory
    );
  end;

implementation

uses
  u_GPSModuleByVSAGPS;

{ TGPSModuleFactoryByZylGPS }

constructor TGPSModuleFactoryByVSAGPS.Create(
  const ASystemTime: ISystemTimeProvider;
  const AGPSPositionFactory: IGPSPositionFactory
);
begin
  inherited Create;
  FSystemTime := ASystemTime;
  FGPSPositionFactory := AGPSPositionFactory;
end;

function TGPSModuleFactoryByVSAGPS.CreateGPSModule: IGPSModuleByCOM;
begin
  Result := TGPSModuleByVSAGPS.Create(FSystemTime, FGPSPositionFactory);
end;

end.
