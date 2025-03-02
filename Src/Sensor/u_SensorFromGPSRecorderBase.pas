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

unit u_SensorFromGPSRecorderBase;

interface

uses
  i_GPSRecorder,
  u_SensorBase;

type
  TSensorDoubeleValueFromGPSRecorder = class(TSensorDoubeleValue)
  private
    FGPSRecorder: IGPSRecorder;
  protected
    property GPSRecorder: IGPSRecorder read FGPSRecorder;
  public
    constructor Create(
      const AGPSRecorder: IGPSRecorder
    );
  end;

  TSensorDateTimeValueFromGPSRecorder = class(TSensorDateTimeValue)
  private
    FGPSRecorder: IGPSRecorder;
  protected
    property GPSRecorder: IGPSRecorder read FGPSRecorder;
  public
    constructor Create(
      const AGPSRecorder: IGPSRecorder
    );
  end;

  TSensorTextValueFromGPSRecorder = class(TSensorTextValue)
  private
    FGPSRecorder: IGPSRecorder;
  protected
    property GPSRecorder: IGPSRecorder read FGPSRecorder;
  public
    constructor Create(
      const AGPSRecorder: IGPSRecorder
    );
  end;

  TSensorGPSSatellitesValueFromGPSRecorder = class(TSensorGPSSatellitesValue)
  private
    FGPSRecorder: IGPSRecorder;
  protected
    property GPSRecorder: IGPSRecorder read FGPSRecorder;
  public
    constructor Create(
      const AGPSRecorder: IGPSRecorder
    );
  end;

implementation

{ TSensorDoubeleValueFromGPSRecorder }

constructor TSensorDoubeleValueFromGPSRecorder.Create(
  const AGPSRecorder: IGPSRecorder
);
begin
  inherited Create(AGPSRecorder.ChangeNotifier);
  FGPSRecorder := AGPSRecorder;
end;

{ TSensorDateTimeValueFromGPSRecorder }

constructor TSensorDateTimeValueFromGPSRecorder.Create(
  const AGPSRecorder: IGPSRecorder
);
begin
  inherited Create(AGPSRecorder.ChangeNotifier);
  FGPSRecorder := AGPSRecorder;
end;

{ TSensorTextValueFromGPSRecorder }

constructor TSensorTextValueFromGPSRecorder.Create(
  const AGPSRecorder: IGPSRecorder);
begin
  inherited Create(AGPSRecorder.ChangeNotifier);
  FGPSRecorder := AGPSRecorder;
end;

{ TSensorGPSSatellitesValueFromGPSRecorder }

constructor TSensorGPSSatellitesValueFromGPSRecorder.Create(
  const AGPSRecorder: IGPSRecorder);
begin
  inherited Create(AGPSRecorder.ChangeNotifier);
  FGPSRecorder := AGPSRecorder;
end;

end.
