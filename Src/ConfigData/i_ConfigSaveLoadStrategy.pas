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

unit i_ConfigSaveLoadStrategy;

interface

uses
  i_ConfigDataProvider,
  i_ConfigDataWriteProvider,
  i_ConfigDataElement;

type
  IConfigSaveLoadStrategy = interface
    ['{B56F4565-5D2D-44BE-966C-F7036C02D538}']
    procedure WriteConfig(
      const AProvider: IConfigDataWriteProvider;
      const AElement: IConfigDataElement
    );
    procedure ReadConfig(
      const AProvider: IConfigDataProvider;
      const AElement: IConfigDataElement
    );
  end;

implementation

end.
