library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use ieee.numeric_std.all;

entity bootloader_dp_32 is
  port (
    CLK:              in std_logic;
    WEA:  in std_logic;
    ENA:  in std_logic;
    MASKA:    in std_logic_vector(3 downto 0);
    ADDRA:         in std_logic_vector(11 downto 2);
    DIA:        in std_logic_vector(31 downto 0);
    DOA:         out std_logic_vector(31 downto 0);
    WEB:  in std_logic;
    ENB:  in std_logic;
    ADDRB:         in std_logic_vector(11 downto 2);
    DIB:        in std_logic_vector(31 downto 0);
    MASKB:    in std_logic_vector(3 downto 0);
    DOB:         out std_logic_vector(31 downto 0)
  );
end entity bootloader_dp_32;

architecture behave of bootloader_dp_32 is

  subtype RAM_WORD is STD_LOGIC_VECTOR (31 downto 0);
  type RAM_TABLE is array (0 to 1023) of RAM_WORD;
 shared variable RAM: RAM_TABLE := RAM_TABLE'(
x"0b0b0b96",x"d8040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b96",x"b9040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fd0608",x"72830609",x"81058205",x"832b2a83",x"ffff0652",x"04000000",x"00000000",x"00000000",x"71fd0608",x"83ffff73",x"83060981",x"05820583",x"2b2b0906",x"7383ffff",x"0b0b0b0b",x"83a70400",x"72098105",x"72057373",x"09060906",x"73097306",x"070a8106",x"53510400",x"00000000",x"00000000",x"72722473",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71737109",x"71068106",x"30720a10",x"0a720a10",x"0a31050a",x"81065151",x"53510400",x"00000000",x"72722673",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"cc040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"720a722b",x"0a535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72729f06",x"0981050b",x"0b0b88af",x"05040000",x"00000000",x"00000000",x"00000000",x"00000000",x"72722aff",x"739f062a",x"0974090a",x"8106ff05",x"06075351",x"04000000",x"00000000",x"00000000",x"71715351",x"020d0406",x"73830609",x"81058205",x"832b0b2b",x"0772fc06",x"0c515104",x"00000000",x"72098105",x"72050970",x"81050906",x"0a810653",x"51040000",x"00000000",x"00000000",x"00000000",x"72098105",x"72050970",x"81050906",x"0a098106",x"53510400",x"00000000",x"00000000",x"00000000",x"71098105",x"52040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72720981",x"05055351",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097206",x"73730906",x"07535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fc0608",x"72830609",x"81058305",x"1010102a",x"81ff0652",x"04000000",x"00000000",x"00000000",x"71fc0608",x"0b0b0b9c",x"fc738306",x"10100508",x"060b0b0b",x"88b20400",x"00000000",x"00000000",x"0b0b0b89",x"80040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"e8040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097081",x"0509060a",x"8106ff05",x"70547106",x"73097274",x"05ff0506",x"07515151",x"04000000",x"72097081",x"0509060a",x"098106ff",x"05705471",x"06730972",x"7405ff05",x"06075151",x"51040000",x"05ff0504",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"810b0b0b",x"0b9df40c",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71810552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"02840572",x"10100552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"717105ff",x"05715351",x"020d0400",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"81dd3f94",x"ca3f0400",x"00000000",x"00000000",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101053",x"51047381",x"ff067383",x"06098105",x"83051010",x"102b0772",x"fc060c51",x"51043c04",x"72728072",x"8106ff05",x"09720605",x"71105272",x"0a100a53",x"72ed3851",x"51535104",x"88088c08",x"90087575",x"97fd2d50",x"50880856",x"900c8c0c",x"880c5104",x"88088c08",x"90087575",x"97b92d50",x"50880856",x"900c8c0c",x"880c5104",x"88088c08",x"90088eba",x"2d900c8c",x"0c880c04",x"ff3d0d0b",x"0b0b9e84",x"335170a6",x"389e8008",x"70085252",x"70802e92",x"3884129e",x"800c702d",x"9e800870",x"08525270",x"f038810b",x"0b0b0b9e",x"8434833d",x"0d040480",x"3d0d0b0b",x"0b9eb008",x"802e8e38",x"0b0b0b0b",x"800b802e",x"09810685",x"38823d0d",x"040b0b0b",x"9eb0510b",x"0b0bf5f8",x"3f823d0d",x"0404ff3d",x"0d80c480",x"80845271",x"0870822a",x"70810651",x"515170f3",x"38833d0d",x"04ff3d0d",x"80c48080",x"84527108",x"70812a70",x"81065151",x"5170f338",x"7382900a",x"0c833d0d",x"04fd3d0d",x"75547333",x"7081ff06",x"53537180",x"2e8e3872",x"81ff0651",x"8aa92d81",x"1454e739",x"853d0d04",x"fe3d0d74",x"7080dc80",x"80880c70",x"81ff06ff",x"83115451",x"53718126",x"8d3880fd",x"518aa92d",x"72a03251",x"83397251",x"8aa92d84",x"3d0d0480",x"3d0d83ff",x"ff0b83d0",x"0a0c80fe",x"518aa92d",x"823d0d04",x"ff3d0d83",x"d00a0870",x"882a5252",x"8aec2d71",x"81ff0651",x"8aec2d80",x"fe518aa9",x"2d833d0d",x"0482f6ff",x"0b80cc80",x"80880c80",x"0b80cc80",x"80840c9f",x"0b83900a",x"0c04ff3d",x"0d737008",x"515180c8",x"80808470",x"08708480",x"8007720c",x"5252833d",x"0d04ff3d",x"0d80c880",x"80847008",x"70fbffff",x"06720c52",x"52833d0d",x"04a0900b",x"a0800c9e",x"880ba084",x"0c96f02d",x"ff3d0d73",x"518b710c",x"90115298",x"8080720c",x"80720c70",x"0883ffff",x"06880c83",x"3d0d04fa",x"3d0d787a",x"7dff1e57",x"57585373",x"ff2ea738",x"80568452",x"75730c72",x"0888180c",x"ff125271",x"f3387484",x"16740872",x"0cff1656",x"565273ff",x"2e098106",x"dd38883d",x"0d04f83d",x"0d80c080",x"80845783",x"d00a0b9d",x"c452598a",x"c92d8c86",x"2d76518c",x"ac2d9e88",x"70880810",x"10988084",x"05717084",x"05530c56",x"56fb8084",x"a1ad750c",x"9db40b88",x"170c8070",x"780c770c",x"760883ff",x"ff06569f",x"df800b88",x"08278f38",x"9dcc518a",x"c92d9df0",x"518ac92d",x"ff3983ff",x"ff790ca0",x"80548808",x"53785276",x"518ccb2d",x"76518bea",x"2d780855",x"74762e89",x"3880c351",x"8aa92dff",x"39a08408",x"5574faa0",x"94a6802e",x"893880c2",x"518aa92d",x"ff399dd0",x"518ac92d",x"900a7008",x"70ffbf06",x"720c5656",x"8a8e2d8c",x"9d2dff3d",x"0d9e9408",x"81119e94",x"0c518390",x"0a700870",x"feff0672",x"0c525283",x"3d0d0480",x"3d0d8b9b",x"2d728180",x"07518aec",x"2d8bb02d",x"823d0d04",x"fe3d0d80",x"c0808084",x"538c862d",x"85730c80",x"730c7208",x"7081ff06",x"74535152",x"8bea2d71",x"880c843d",x"0d0404f9",x"3d0d7957",x"80c08080",x"84568c86",x"2d811733",x"82183371",x"82802905",x"53537180",x"2e943885",x"17725553",x"72708105",x"5433760c",x"ff145473",x"f3388317",x"33841833",x"71828029",x"05565280",x"54737527",x"97387358",x"77760c73",x"17760853",x"53717334",x"81145474",x"7426ed38",x"75518bea",x"2d8b9b2d",x"8184518a",x"ec2d7488",x"2a518aec",x"2d74518a",x"ec2d8054",x"7375278f",x"38731770",x"3352528a",x"ec2d8114",x"54ee398b",x"b02d893d",x"0d0404fc",x"3d0d7681",x"11338212",x"3371902b",x"71882b07",x"83143370",x"7207882b",x"84163371",x"07515253",x"57575452",x"88518ed7",x"2d81ff51",x"8aa92d80",x"c4808084",x"53720870",x"812a7081",x"06515152",x"71f33873",x"84808007",x"80c48080",x"840c863d",x"0d04fe3d",x"0d8eec2d",x"88088808",x"81065353",x"71f3388b",x"9b2d8183",x"518aec2d",x"72518aec",x"2d8bb02d",x"843d0d04",x"fe3d0d80",x"0b9e940c",x"8b9b2d81",x"81518aec",x"2d9db453",x"8f527270",x"81055433",x"518aec2d",x"ff125271",x"ff2e0981",x"06ec388b",x"b02d843d",x"0d04fe3d",x"0d800b9e",x"940c8b9b",x"2d818251",x"8aec2d80",x"c0808084",x"528c862d",x"81f90a0b",x"80c08080",x"9c0c7108",x"7252538b",x"ea2d729e",x"9c0c7290",x"2a518aec",x"2d9e9c08",x"882a518a",x"ec2d9e9c",x"08518aec",x"2d8eec2d",x"8808518a",x"ec2d8bb0",x"2d843d0d",x"04803d0d",x"810b9e98",x"0c800b83",x"900a0c85",x"518ed72d",x"823d0d04",x"803d0d80",x"0b9e980c",x"8bd12d86",x"518ed72d",x"823d0d04",x"fd3d0d80",x"c0808084",x"548a518e",x"d72d8c86",x"2d9e8874",x"52538cac",x"2d728808",x"10109880",x"84057170",x"8405530c",x"52fb8084",x"a1ad720c",x"9db40b88",x"140c7351",x"8bea2d8a",x"8e2d8c9d",x"2dffab3d",x"0d800b9e",x"980c800b",x"9e940c80",x"0b8eba0b",x"a0800c57",x"80c48080",x"84558480",x"b3750c80",x"c88080a4",x"53fbffff",x"73087072",x"06750c53",x"5480c880",x"80947008",x"70760672",x"0c5353a8",x"7098b571",x"70840553",x"0c999271",x"0c539aab",x"0b88120c",x"9bba0b8c",x"120c5388",x"0b80d080",x"80840c80",x"d00a5381",x"730c9de8",x"518ac92d",x"8bd12d82",x"88880b80",x"dc808084",x"0c81f20b",x"900a0c80",x"c0808084",x"7052528b",x"ea2d8c86",x"2d71518b",x"ea2d7677",x"7675933d",x"41415b5b",x"5b83d00a",x"5c780870",x"81065152",x"719d389e",x"98085372",x"f0389e94",x"085287e8",x"7227e638",x"727e0c72",x"83900a0c",x"96e92d82",x"900a0853",x"79802e81",x"b4387280",x"fe2e0981",x"0680f438",x"76802ec1",x"38807d78",x"58565a82",x"7727ffb5",x"3883ffff",x"7c0c79fe",x"18535379",x"72279838",x"80dc8080",x"88725558",x"72157033",x"790c5281",x"13537373",x"26f238ff",x"16751154",x"7505ff05",x"70337433",x"7072882b",x"077f0853",x"51555152",x"71732e09",x"8106feed",x"38743353",x"728a26fe",x"e4387210",x"109d8805",x"75527008",x"5152712d",x"fed33972",x"80fd2e09",x"81068638",x"815bfec5",x"3976829f",x"269e387a",x"802e8738",x"8073a032",x"545b80d7",x"3d7705fd",x"e0055272",x"72348117",x"57fea239",x"805afe9d",x"397280fe",x"2e098106",x"fe933879",x"5783ffff",x"7c0c8177",x"5c5afe85",x"39803d0d",x"88088c08",x"9008a080",x"0851702d",x"900c8c0c",x"8a0c810b",x"80d00a0c",x"823d0d04",x"ff3d0d97",x"8d2d8052",x"80519395",x"2d833d0d",x"049ffff8",x"0d8d8604",x"9ffff80d",x"a0880400",x"00000000",x"00000000",x"820b80d0",x"8080900c",x"0b0b0b04",x"0083f00a",x"0b800ba0",x"80721208",x"720c8412",x"5271712e",x"ff05f238",x"028c050d",x"97800400",x"00000000",x"00000000",x"00000000",x"00fb3d0d",x"77795555",x"80567575",x"24ab3880",x"74249d38",x"80537352",x"745180e1",x"3f880854",x"75802e85",x"38880830",x"5473880c",x"873d0d04",x"73307681",x"325754dc",x"39743055",x"81567380",x"25d238ec",x"39fa3d0d",x"787a5755",x"80577675",x"24a43875",x"9f2c5481",x"53757432",x"74315274",x"519b3f88",x"08547680",x"2e853888",x"08305473",x"880c883d",x"0d047430",x"558157d7",x"39fc3d0d",x"76785354",x"81538074",x"73265255",x"72802e98",x"3870802e",x"a9388072",x"24a43871",x"10731075",x"72265354",x"5272ea38",x"73517883",x"38745170",x"880c863d",x"0d047281",x"2a72812a",x"53537280",x"2ee63871",x"7426ef38",x"73723175",x"74077481",x"2a74812a",x"55555654",x"e539fc3d",x"0d767079",x"7b555555",x"558f7227",x"8c387275",x"07830651",x"70802ea7",x"38ff1252",x"71ff2e98",x"38727081",x"05543374",x"70810556",x"34ff1252",x"71ff2e09",x"8106ea38",x"74880c86",x"3d0d0474",x"51727084",x"05540871",x"70840553",x"0c727084",x"05540871",x"70840553",x"0c727084",x"05540871",x"70840553",x"0c727084",x"05540871",x"70840553",x"0cf01252",x"718f26c9",x"38837227",x"95387270",x"84055408",x"71708405",x"530cfc12",x"52718326",x"ed387054",x"ff8339fc",x"3d0d7679",x"71028c05",x"9f053357",x"55535583",x"72278a38",x"74830651",x"70802ea2",x"38ff1252",x"71ff2e93",x"38737370",x"81055534",x"ff125271",x"ff2e0981",x"06ef3874",x"880c863d",x"0d047474",x"882b7507",x"7071902b",x"07515451",x"8f7227a5",x"38727170",x"8405530c",x"72717084",x"05530c72",x"71708405",x"530c7271",x"70840553",x"0cf01252",x"718f26dd",x"38837227",x"90387271",x"70840553",x"0cfc1252",x"718326f2",x"387053ff",x"9039fb3d",x"0d777970",x"72078306",x"53545270",x"93387173",x"73085456",x"54717308",x"2e80c438",x"73755452",x"71337081",x"ff065254",x"70802e9d",x"38723355",x"70752e09",x"81069538",x"81128114",x"71337081",x"ff065456",x"545270e5",x"38723355",x"7381ff06",x"7581ff06",x"71713188",x"0c525287",x"3d0d0471",x"0970f7fb",x"fdff1406",x"70f88482",x"81800651",x"51517097",x"38841484",x"16710854",x"56547175",x"082edc38",x"73755452",x"ff963980",x"0b880c87",x"3d0d04ff",x"3d0d9ea4",x"0bfc0570",x"08525270",x"ff2e9138",x"702dfc12",x"70085252",x"70ff2e09",x"8106f138",x"833d0d04",x"04ecb13f",x"04000000",x"00ffffff",x"ff00ffff",x"ffff00ff",x"ffffff00",x"000008a0",x"000008d2",x"0000087a",x"00000793",x"00000929",x"00000940",x"00000826",x"00000827",x"00000792",x"00000954",x"01090600",x"0007ef80",x"05b8d800",x"a4051300",x"43500d0a",x"00000000",x"534c4b00",x"4c6f6164",x"65642c20",x"73746172",x"74696e67",x"2e2e2e0d",x"0a000000",x"0d0a5a50",x"55494e4f",x"0d0a0000",x"00000000",x"00000000",x"00000000",x"00000f2c",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"ffffffff",x"00000000",x"ffffffff",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000");

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if ENA='1' then
        if WEA='1' then
          RAM(conv_integer(ADDRA) ) := DIA;
        end if;
        DOA <= RAM(conv_integer(ADDRA)) ;
      end if;
    end if;
  end process;  

  process (clk)
  begin
    if rising_edge(clk) then
      if ENB='1' then
        if WEB='1' then
          RAM( conv_integer(ADDRB) ) := DIB;
        end if;
        DOB <= RAM(conv_integer(ADDRB)) ;
      end if;
    end if;
  end process;  
end behave;
