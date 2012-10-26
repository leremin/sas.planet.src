unit u_Bitmap32Static;

interface

uses
  GR32,
  i_Bitmap32Static;

type
  TBitmap32Static = class(TInterfacedObject, IBitmap32Static)
  private
    FSize: TPoint;
    FBitmap: TCustomBitmap32;
  private
    function GetSize: TPoint;
    function GetData: PColor32Array;
  public
    constructor CreateWithCopy(ABitmap: TCustomBitmap32);
    constructor CreateWithOwn(ABitmap: TCustomBitmap32);
    destructor Destroy; override;
  end;

implementation

uses
  Types,
  SysUtils;

{ TBitmap32Static }

constructor TBitmap32Static.CreateWithCopy(ABitmap: TCustomBitmap32);
var
  VBitmap: TCustomBitmap32;
begin
  VBitmap := TCustomBitmap32.Create;
  try
    VBitmap.Assign(ABitmap);
    CreateWithOwn(VBitmap);
    VBitmap := nil;
  finally
    VBitmap.Free;
  end;
end;

constructor TBitmap32Static.CreateWithOwn(ABitmap: TCustomBitmap32);
begin
  inherited Create;
  FBitmap := ABitmap;
  FSize := Point(FBitmap.Width, FBitmap.Height);
end;

destructor TBitmap32Static.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

function TBitmap32Static.GetData: PColor32Array;
begin
  Result := FBitmap.Bits;
end;

function TBitmap32Static.GetSize: TPoint;
begin
  Result := FSize;
end;

end.
