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

unit i_MainFormBehaviourByGPSConfig;

interface

uses
  i_ConfigDataElement;

type
  IMainFormBehaviourByGPSConfig = interface(IConfigDataElement)
    ['{2236C930-B6F6-4A6D-A8EB-FC83999973EA}']
    // ������� ����� ��� ��������� gps-���������
    function GetMapMove: Boolean;
    procedure SetMapMove(AValue: Boolean);
    property MapMove: Boolean read GetMapMove write SetMapMove;

    // ������������ ����� �� GPS �������
    function GetMapMoveCentered: Boolean;
    procedure SetMapMoveCentered(AValue: Boolean);
    property MapMoveCentered: Boolean read GetMapMoveCentered write SetMapMoveCentered;

    // ����������, �� ������� ������� ���������� ��������� GPS ��� �� ������� ���� �����
    function GetMinMoveDelta: Double;
    procedure SetMinMoveDelta(AValue: Double);
    property MinMoveDelta: Double read GetMinMoveDelta write SetMinMoveDelta;

    // ��������/���������� ������ �������� ��� �����������/���������� GPS
    function GetSensorsAutoShow: Boolean;
    procedure SetSensorsAutoShow(AValue: Boolean);
    property SensorsAutoShow: Boolean read GetSensorsAutoShow write SetSensorsAutoShow;

    // ������� ����� � �������������� ���� ������ ���� ������� ���� �������
    function GetProcessGPSIfActive: Boolean;
    procedure SetProcessGPSIfActive(AValue: Boolean);
    property ProcessGPSIfActive: Boolean read GetProcessGPSIfActive write SetProcessGPSIfActive;
  end;

implementation

end.
