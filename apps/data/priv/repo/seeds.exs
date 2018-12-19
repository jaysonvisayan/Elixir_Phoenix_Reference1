alias Data.{
  Seeders.BenefitSeeder,
  Seeders.BenefitLimitSeeder,
  Seeders.GenericLookUpSeeder,
  Seeders.AccountSeeder,
  Seeders.AddressLookUpSeeder,
  Seeders.ExclusionSeeder,
  Seeders.DiagnosisSeeder,
  Seeders.PackageSeeder,
  Seeders.ProcedureSeeder,
  Seeders.PlanSeeder,
}

#Creating Packages

IO.puts "Seeding packages for health..."
package_data = [
  #1
  %{
    code: "PCODE011",
    name: "Test1",
  },
  #2
  %{
    code: "PCODE022",
    name: "Test2",
  },
  #3
  %{
    code: "PCODE033",
    name: "Test3",
  },
]
[pc1, pc2, pc3] = PackageSeeder.seed(package_data)

#Creating Benefits

IO.puts "Seeding benefits for health..."
benefit_data = [
  #1
  %{
    code: "B01020",
    name: "Medilink Benefit",
    type: "Health Plan",
    updated_by: "Masteradmin",
    packages: [pc1.code]
  },
  #2
  %{
    code: "B01030",
    name: "Accenture Benefit",
    type: "Riders",
    updated_by: "Masteradmin",
    packages: [pc2.code]
  },
  #3
  %{
    code: "B01010",
    name: "ACU",
    type: "Riders",
    updated_by: "Masteradmin",
    packages: [pc3.code]
  },
]
[b1, b2, b3] = BenefitSeeder.seed(benefit_data)

#Creating Benefit Limits

IO.puts "Seeding benefit limits"
benefit_limit_data = [
  #1
  %{
    coverage_codes: ["Inpatient", "Outpatient", "Emergency"],
    benefit_code: b1.code
  },
  #2
  %{
    coverage_codes: ["Maternity"],
    benefit_code: b2.code
  },
  #3
  %{
    coverage_codes: ["Dental", "ACU Regular"],
    benefit_code: b3.code
  },
]
[bl1, bl2, bl3] = BenefitLimitSeeder.seed(benefit_limit_data)

#Creating Industries
IO.puts "Seeding industries..."
industry_data =
[
  #1
  %{
    code: "A01",
    type: "industry",
    name: "ADVERTISING",
    description: "ADVERTISING"
  },
  #2
  %{
    code: "A02",
    type: "industry",
    name: "AGRICULTURAL SERVICES",
    description: "AGRICULTURAL SERVICES"
  },
  #3
  %{
    code: "A03",
    type: "industry",
    name: "AGRICULTURE & AGRICULTURAL CROPS PRODUCT",
    description: "AGRICULTURE & AGRICULTURAL CROPS PRODUCT"
  },
  #4
  %{
    code: "A05",
    type: "industry",
    name: "ANIMAL FEED MILLING",
    description: "ANIMAL FEED MILLING"
  },
  #5
  %{
    code: "A06",
    type: "industry",
    name: "AUTOMOBILE SALES",
    description: "AUTOMOBILE SALES"
  },
  #6
  %{
    code: "A07",
    type: "industry",
    name: "AGENCY",
    description: "AGENCY"
  },
  #7
  %{
    code: "B01",
    type: "industry",
    name: "BANKING & FINANCE",
    description: "BANKING & FINANCE"
  },
  #8
  %{
    code: "B02",
    type: "industry",
    name: "BROADCASTING & MEDIA",
    description: "BROADCASTING & MEDIA"
  },
  #9
  %{
    code: "B03",
    type: "industry",
    name: "BROKERS & AGENT",
    description: "BROKERS & AGENT"
  },
  #10
  %{
    code: "C01" ,
    type: "industry",
    name: "CABLE SALES & SERVICES",
    description: "CABLE SALES & SERVICES"
  },
  #11
  %{
    code: "C02" ,
    type: "industry",
    name: "CLERICAL OCCUPATIONS",
    description: "CLERICAL OCCUPATIONS"
  },
  #12
  %{
    code: "C03" ,
    type: "industry",
    name: "COMMUNICATION & TELECOMMUNICATION SERVICES",
    description: "COMMUNICATION & TELECOMMUNICATION SERVICES"
  },
  #13
  %{
    code: "C04" ,
    type: "industry",
    name: "COMMUNITY, SOCIAL, & PERSONAL SERVICES",
    description: "COMMUNITY, SOCIAL, & PERSONAL SERVICES"
  },
  #14
  %{
    code: "C05" ,
    type: "industry",
    name: "CONSTRUCTION",
    description: "CONSTRUCTION"
  },
  #15
  %{
    code: "C06" ,
    type: "industry",
    name: "CONSULTANCY",
    description: "CONSULTANCY"
  },
  #16
  %{
    code: "C07" ,
    type: "industry",
    name: "CALIBRATION SERVICES AND TRADING",
    description: "CALIBRATION SERVICES AND TRADING"
  },
  #17
  %{
    code: "C08" ,
    type: "industry",
    name: "CONDO",
    description: "CONDO"
  },
  #18
  %{
    code: "A00" ,
    type: "industry",
    name: "ACTIVITIES NOT ADEQUATELY DEFINED",
    description: "ACTIVITIES NOT ADEQUATELY DEFINED"
  },
  #19
  %{
    code: "D01" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF EXPLOSIVES/AMMUNITIONS",
    description: "DISTRIBUTION/SUPPLY OF EXPLOSIVES/AMMUNITIONS"
  },
  #20
  %{
    code: "D02" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF CHEMICAL PRODUCTS",
    description: "DISTRIBUTION/SUPPLY OF CHEMICAL PRODUCTS"
  },
  #21
  %{
    code: "D03" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF ELECTRONIC PRODUCTS",
    description: "DISTRIBUTION/SUPPLY OF ELECTRONIC PRODUCTS"
  },
  #22
  %{
    code: "D04" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF FOOD & BEVERAGES",
    description: "DISTRIBUTION/SUPPLY OF FOOD & BEVERAGES"
  },
  #23
  %{
    code: "D05" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF GARMENTS, TEXTILE",
    description: "DISTRIBUTION/SUPPLY OF GARMENTS, TEXTILE"
  },
  #24
  %{
    code: "D06" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF HAND-MADE PRODUCT,",
    description: "DISTRIBUTION/SUPPLY OF HAND-MADE PRODUCT,"
  },
  #25
  %{
    code: "D07" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF HOME NECESSITIES",
    description: "DISTRIBUTION/SUPPLY OF HOME NECESSITIES"
  },
  #26
  %{
    code: "D08" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF MECHANICAL/METALLIC PRODUCTS",
    description: "DISTRIBUTION/SUPPLY OF MECHANICAL/METALLIC PRODUCTS"
  },
  #27
  %{
    code: "D09" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF MEDICINES AND DRUGS (PHARMACEUTICAL GROUPS)",
    description: "DISTRIBUTION/SUPPLY OF MEDICINES AND DRUGS (PHARMACEUTICAL GROUPS)"
  },
  #28
  %{
    code: "D10" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF PAPER & PAPER PRODUCTS",
    description: "DISTRIBUTION/SUPPLY OF PAPER & PAPER PRODUCTS"
  },
  #29
  %{
    code: "D11" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF PETROLEUM, OIL & COAL",
    description: "DISTRIBUTION/SUPPLY OF PETROLEUM, OIL & COAL"
  },
  #30
  %{
    code: "D12" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF RAW MATERIALS",
    description: "DISTRIBUTION/SUPPLY OF RAW MATERIALS"
  },
  #31
  %{
    code: "D13" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF RUBBER & PLASTIC PRODUCTS",
    description: "DISTRIBUTION/SUPPLY OF RUBBER & PLASTIC PRODUCTS"
  },
  #32
  %{
    code: "D14",
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF SEMICONDUCTOR",
    description: "DISTRIBUTION/SUPPLY OF SEMICONDUCTOR"
  },
  #33
  %{
    code: "D15" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF WOOD & WOOD PRODUCTS",
    description: "DISTRIBUTION/SUPPLY OF WOOD & WOOD PRODUCTS"
  },
  #34
  %{
    code: "D16" ,
    type: "industry",
    name: "DOMESTIC & PERSONAL SERVICES",
    description: "DOMESTIC & PERSONAL SERVICES"
  },
  #35
  %{
    code: "D17" ,
    type: "industry",
    name: "DISTRIBUTION/SUPPLY OF MEDICAL/LABORATORY EQUIPMENT",
    description: "DISTRIBUTION/SUPPLY OF MEDICAL/LABORATORY EQUIPMENT"
  },
  #36
  %{
    code: "E01" ,
    type: "industry",
    name: "EDUCATION",
    description: "EDUCATION"
  },
  #37
  %{
    code: "E02" ,
    type: "industry",
    name: "ELECTRICAL SERVICES",
    description: "ELECTRICAL SERVICES"
  },
  #38
  %{
    code: "E03" ,
    type: "industry",
    name: "EMBASSY",
    description: "EMBASSY"
  },
  #39
  %{
    code: "E04" ,
    type: "industry",
    name: "ENGINEERING &/OR ARCHITECTURAL SERVICE",
    description: "ENGINEERING &/OR ARCHITECTURAL SERVICE"
  },
  #40
  %{
    code: "E05" ,
    type: "industry",
    name: "Elevator Business",
    description: "Elevator Business"
  },
  #41
  %{
    code: "F01" ,
    type: "industry",
    name: "FINANCIAL INTERMEDIARIES",
    description: "FINANCIAL INTERMEDIARIES"
  },
  #42
  %{
    code: "F02" ,
    type: "industry",
    name: "FINANCIAL INVESTMENTS",
    description: "FINANCIAL INVESTMENTS"
  },
  #43
  %{
    code: "F03" ,
    type: "industry",
    name: "FISHERY",
    description: "FISHERY"
  },
  #44
  %{
    code: "F05" ,
    type: "industry",
    name: "FREIGHT FORWARDING/SHIPPING",
    description: "FREIGHT FORWARDING/SHIPPING"
  },
  #45
  %{
    code: "FO4" ,
    type: "industry",
    name: "FORESTRY",
    description: "FORESTRY"
  },
  #46
  %{
    code: "G01" ,
    type: "industry",
    name: "GAS & STEAM",
    description: "GAS & STEAM"
  },
  #47
  %{
    code: "G02" ,
    type: "industry",
    name: "GOVERNMENT OFFICE/SECTOR/INSTITUTION",
    description: "GOVERNMENT OFFICE/SECTOR/INSTITUTION"
  },
  #48
  %{
    code: "H01" ,
    type: "industry",
    name: "HEALTH CARE PROVIDER",
    description: "HEALTH CARE PROVIDER"
  },
  #49
  %{
    code: "H02" ,
    type: "industry",
    name: "HEALTH MAINTENANCE ORGANIZATION (HMO)",
    description: "HEALTH MAINTENANCE ORGANIZATION (HMO)"
  },
  #50
  %{
    code: "H03" ,
    type: "industry",
    name: "HOLDINGS",
    description: "HOLDINGS"
  },
  #51
  %{
    code: "H04" ,
    type: "industry",
    name: "HOTEL",
    description: "HOTEL"
  },
  #52
  %{
    code: "I01" ,
    type: "industry",
    name: "IMPORT &/OR EXPORT",
    description: "IMPORT &/OR EXPORT"
  },
  #53
  %{
    code: "I02" ,
    type: "industry",
    name: "INTERIOR DESIGNING",
    description: "INTERIOR DESIGNING"
  },
  #54
  %{
    code: "L01" ,
    type: "industry",
    name: "LAW FIRM/PUBLIC ADMINISTRATION & DEFEN",
    description: "LAW FIRM/PUBLIC ADMINISTRATION & DEFEN"
  },
  #55
  %{
    code: "L02" ,
    type: "industry",
    name: "LEASING/RENTING",
    description: "LEASING/RENTING"
  },
  #56
  %{
    code: "L03" ,
    type: "industry",
    name: "LENDING COMPANY/PAWNSHOP",
    description: "LENDING COMPANY/PAWNSHOP"
  },
  #57
  %{
    code: "L04" ,
    type: "industry",
    name: "LIFE/HEALTH INSURANCE & PRE-NEED,",
    description: "LIFE/HEALTH INSURANCE & PRE-NEED,"
  },
  #58
  %{
    code: "L05" ,
    type: "industry",
    name: "LIVESTOCK, POULTRY & OTHER ANIMALS",
    description: "LIVESTOCK, POULTRY & OTHER ANIMALS"
  },
  #59
  %{
    code: "M01" ,
    type: "industry",
    name: "MANAGEMENT SERVICES",
    description: "MANAGEMENT SERVICES"
  },
  #60
  %{
    code: "M02" ,
    type: "industry",
    name: "MANUFACTURING OF CHEMICAL PRODUCTS",
    description: "MANUFACTURING OF CHEMICAL PRODUCTS"
  },
  #61
  %{
    code: "M03" ,
    type: "industry",
    name: "MANUFACTURING OF ELECTRONIC PRODUCTS",
    description: "MANUFACTURING OF ELECTRONIC PRODUCTS"
  },
  #62
  %{
    code: "M04" ,
    type: "industry",
    name: "MANUFACTURING OF EXPLOSIVES/AMMUNITIONS",
    description: "MANUFACTURING OF EXPLOSIVES/AMMUNITIONS"
  },
  #63
  %{
    code: "M05" ,
    type: "industry",
    name: "MANUFACTURING OF FOOD, BEVERAGES AND TOBACCO",
    description: "MANUFACTURING OF FOOD, BEVERAGES AND TOBACCO"
  },
  #64
  %{
    code: "M06" ,
    type: "industry",
    name: "MANUFACTURING OF GARMENTS & TEXTILES",
    description: "MANUFACTURING OF GARMENTS & TEXTILES"
  },
  #65
  %{
    code: "M07" ,
    type: "industry",
    name: "MANUFACTURING OF HAND-MADE PRODUCTS,",
    description: "MANUFACTURING OF HAND-MADE PRODUCTS,"
  },
  #66
  %{
    code: "M08" ,
    type: "industry",
    name: "MANUFACTURING OF HOME NECESSITIES",
    description: "MANUFACTURING OF HOME NECESSITIES"
  },
  #67
  %{
    code: "M09" ,
    type: "industry",
    name: "MANUFACTURING OF MECHANICAL/METALLIC PRODUCTS",
    description: "MANUFACTURING OF MECHANICAL/METALLIC PRODUCTS"
  },
  #68
  %{
    code: "M10" ,
    type: "industry",
    name: "MANUFACTURING OF MEDICINES AND DRUGS",
    description: "MANUFACTURING OF MEDICINES AND DRUGS"
  },
  #69
  %{
    code: "M11" ,
    type: "industry",
    name: "MANUFACTURING OF PAPER & PAPER PRODUCTS",
    description: "MANUFACTURING OF PAPER & PAPER PRODUCTS"
  },
  #70
  %{
    code: "M12" ,
    type: "industry",
    name: "MANUFACTURING OF PETROLEUM, OIL & COAL",
    description: "MANUFACTURING OF PETROLEUM, OIL & COAL"
  },
  #71
  %{
    code: "M13" ,
    type: "industry",
    name: "MANUFACTURING OF RUBBER & PLASTIC PRODUC",
    description: "MANUFACTURING OF RUBBER & PLASTIC PRODUC"
  },
  #72
  %{
    code: "M14" ,
    type: "industry",
    name: "MANUFACTURING OF WOOD & WOOD PRODUCTS",
    description: "MANUFACTURING OF WOOD & WOOD PRODUCTS"
  },
  #73
  %{
    code: "M15" ,
    type: "industry",
    name: "MARKETING & SALES",
    description: "MARKETING & SALES"
  },
  #74
  %{
    code: "M16" ,
    type: "industry",
    name: "MINING/QUARRYING OF METALLIC MINERALS",
    description: "MINING/QUARRYING OF METALLIC MINERALS"
  },
  #75
  %{
    code: "M17" ,
    type: "industry",
    name: "MINING/QUARRYING OF NON-METALLIC MINERAL,",
    description: "MINING/QUARRYING OF NON-METALLIC MINERAL,"
  },
  #76
  %{
    code: "M18" ,
    type: "industry",
    name: "MEDIA AND PUBLISHING",
    description: "MEDIA AND PUBLISHING"
  },
  #77
  %{
    code: "M19" ,
    type: "industry",
    name: "Merchandising",
    description: "Merchandising"
  },
  #78
  %{
    code: "N01" ,
    type: "industry",
    name: "NGO/COOPERATIVE/FOUNDATION",
    description: "NGO/COOPERATIVE/FOUNDATION"
  },
  #79
  %{
    code: "N02" ,
    type: "industry",
    name: "NON GAINFUL OCCUPATIONS",
    description: "NON GAINFUL OCCUPATIONS"
  },
  #80
  %{
    code: "N03" ,
    type: "industry",
    name: "NON-LIFE INSURANCE",
    description: "NON-LIFE INSURANCE"
  },
  #81
  %{
    code: "N04" ,
    type: "industry",
    name: "NUCLEAR/CHEMICAL/ELECTRICAL PLANT",
    description: "NUCLEAR/CHEMICAL/ELECTRICAL PLANT"
  },
  #82
  %{
    code: "O00" ,
    type: "industry",
    name: "OIL AND GAS EXPLORATION",
    description: "OIL AND GAS EXPLORATION"
  },
  #83
  %{
    code: "P01" ,
    type: "industry",
    name: "PHOTOGRAPH SALES & SERVICES",
    description: "PHOTOGRAPH SALES & SERVICES"
  },
  #84
  %{
    code: "P06" ,
    type: "industry",
    name: "PUBLIC SERVICE",
    description: "PUBLIC SERVICE"
  },
  #85
  %{
    code: "R04" ,
    type: "industry",
    name: "REPAIR AND ASSEMBLING",
    description: "REPAIR AND ASSEMBLING"
  },
  #86
  %{
    code: "S02" ,
    type: "industry",
    name: "SPORTS, ATHLETICS & RECREATIONAL FACILITY",
    description: "SPORTS, ATHLETICS & RECREATIONAL FACILITY"
  },
  #87
  %{
    code: "T01" ,
    type: "industry",
    name: "TRAVEL AGENCY",
    description: "TRAVEL AGENCY"
  },
  #88
  %{
    code: "W01" ,
    type: "industry",
    name: "WATER TREATMENT",
    description: "WATER TREATMENT"
  },
  #89
  %{
    code: "P02" ,
    type: "industry",
    name: "POLITICAL ORGANIZATION",
    description: "POLITICAL ORGANIZATION"
  },
  #90
  %{
    code: "P07" ,
    type: "industry",
    name: "PVC MANUFACTURING",
    description: "PVC MANUFACTURING"
  },
  #91
  %{
    code: "R05" ,
    type: "industry",
    name: "RESEARCH",
    description: "RESEARCH"
  },
  #92
  %{
    code: "S03" ,
    type: "industry",
    name: "STOCKS EXCHANGE",
    description: "STOCKS EXCHANGE"
  },
  #93
  %{
    code: "T02" ,
    type: "industry",
    name: "THERAPEUTIC CENTER/SPA/HEALTH RESORT",
    description: "THERAPEUTIC CENTER/SPA/HEALTH RESORT"
  },
  #94
  %{
    code: "W02" ,
    type: "industry",
    name: "WATERWORKS & SUPPLY",
    description: "WATERWORKS & SUPPLY"
  },
  #95
  %{
    code: "P03" ,
    type: "industry",
    name: "PRINTING & PUBLISHING",
    description: "PRINTING & PUBLISHING"
  },
  #96
  %{
    code: "R01" ,
    type: "industry",
    name: "REAL ESTATE DEVELOPMENT",
    description: "REAL ESTATE DEVELOPMENT"
  },
  #97
  %{
    code: "R06" ,
    type: "industry",
    name: "RESTAURANT/FASTFOOD/CAFE",
    description: "RESTAURANT/FASTFOOD/CAFE"
  },
  #98
  %{
    code: "S04" ,
    type: "industry",
    name: "STORAGE & WAREHOUSING",
    description: "STORAGE & WAREHOUSING"
  },
  #99
  %{
    code: "T03" ,
    type: "industry",
    name: "TRAINING SERVICES",
    description: "TRAINING SERVICES"
  },
  #100
  %{
    code: "W03" ,
    type: "industry",
    name: "WEDDING PLANNING",
    description: "WEDDING PLANNING"
  },
  #101
  %{
    code: "P04" ,
    type: "industry",
    name: "PROFESSIONAL SERVICE",
    description: "PROFESSIONAL SERVICE"
  },
  #102
  %{
    code: "R02" ,
    type: "industry",
    name: "RECORDING/STUDIO COMPANY",
    description: "RECORDING/STUDIO COMPANY"
  },
  #103
  %{
    code: "R07" ,
    type: "industry",
    name: "RENEWABLE ENERGY RESOURCING COMPANY",
    description: "RENEWABLE ENERGY RESOURCING COMPANY"
  },
  #104
  %{
    code: "S05" ,
    type: "industry",
    name: "SYSTEM/SOFTWARE DEVELOPMENT/INFORMATION TECHNOLOGY",
    description: "SYSTEM/SOFTWARE DEVELOPMENT/INFORMATION TECHNOLOGY"
  },
  #105
  %{
    code: "T04" ,
    type: "industry",
    name: "TRANSPORTATION",
    description: "TRANSPORTATION"
  },
  #106
  %{
    code: "W04" ,
    type: "industry",
    name: "WHOLESALE &/OR RETAIL TRADE",
    description: "WHOLESALE &/OR RETAIL TRADE"
  },
  #107
  %{
    code: "P05" ,
    type: "industry",
    name: "PROTECTION SERVICES",
    description: "PROTECTION SERVICES"
  },
  #108
  %{
    code: "R03" ,
    type: "industry",
    name: "RELIGIOUS ORGANIZATION/CHURCH",
    description: "RELIGIOUS ORGANIZATION/CHURCH"
  },
  #109
  %{
    code: "S01" ,
    type: "industry",
    name: "SEMICONDUCTOR",
    description: "SEMICONDUCTOR"
  },
  #110
  %{
    code: "S06" ,
    type: "industry",
    name: "SCHOOL",
    description: "SCHOOL"
  },
  #111
  %{
    code: "V01" ,
    type: "industry",
    name: "VETERINARY SERVICES",
    description: "VETERINARY SERVICES"
  },
  #112
  %{
    code: "U01" ,
    type: "industry",
    name: "UNDEFINED",
    description: "UNDEFINED"
  }
]

GenericLookUpSeeder.seed(industry_data)

#Creating Segments
IO.puts "Seeding segments..."
segment_data = [
  #1
  %{
    code: "C",
    type: "account_segment",
    name: "Corporate",
    description: "Corporate"
  },
  #2
  %{
    code: "I",
    type: "account_segment",
    name: "Individual",
    description: "Individual"
  },
  #3
  %{
    code: "F",
    type: "account_segment",
    name: "Family",
    description: "Family"
  },
  #4
  %{
    code: "G",
    type: "account_segment",
    name: "Group",
    description: "Group"
  },
]
[s1, s2, s3, s4] = GenericLookUpSeeder.seed(segment_data)

#Creating Account Types
IO.puts "Seeding account_types..."
account_type_data = [
  #1
  %{
    code: "H",
    type: "account_type",
    name: "Headquarters",
    description: "Headquarters"
  },
  #2
  %{
    code: "S",
    type: "account_type",
    name: "Subsidiary",
    description: "Subsidiary"
  },
  #3
  %{
    code: "B",
    type: "account_type",
    name: "Branch",
    description: "Branch"
  }
]
[at1, at2, at3] = GenericLookUpSeeder.seed(account_type_data)

#Creating Address Look Ups
IO.puts "Seeding address_look_ups..."
address_look_up_data = [
    #1
  %{
    region: "ARMM",
    region_name: "",
    province: "Basilan",
    city_municipal: "Lamitan"
  },
  #2
  %{
    region: "ARMM",
    region_name: "",
    province: "Basilan",
    city_municipal: "Lantawan"
  },
  #3
  %{
    region: "ARMM",
    region_name: "",
    province: "Basilan",
    city_municipal: "Maluso"
  },
  #4
  %{
    region: "ARMM",
    region_name: "",
    province: "Basilan",
    city_municipal: "Sumisip"
  },
  #5
  %{
    region: "ARMM",
    region_name: "",
    province: "Basilan",
    city_municipal: "Tipo-Tipo"
  },
  #6
  %{
    region: "ARMM",
    region_name: "",
    province: "Basilan",
    city_municipal: "Tuburan"
  },
  #7
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Bacolod-Kalawi (Bacolod Grande)"
  },
  #8
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Balabagan"
  },
  #9
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Balindong (Watu)"
  },
  #10
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Bayang"
  },
  #11
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Binidayan"
  },
  #12
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Buadiposo-Buntong"
  },
  #13
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Bubong"
  },
  #14
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Bumbaran"
  },
  #15
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Butig"
  },
  #16
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Calanogas"
  },
  #17
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Ditsaan-Ramain"
  },
  #18
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Ganassi"
  },
  #19
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Kapai"
  },
  #20
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Kapatagan"
  },
  #21
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Lumba-Bayabao (Maguing)"
  },
  #22
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Lumbaca-Unayan"
  },
  #23
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Lumbatan"
  },
  #24
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Lumbayanague"
  },
  #25
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Madalum"
  },
  #26
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Madamba"
  },
  #27
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Maguing"
  },
  #28
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Malabang"
  },
  #29
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Marantao"
  },
  #30
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Marawi City"
  },
  #31
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Marogong"
  },
  #32
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Masiu"
  },
  #33
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Mulondo"
  },
  #34
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Pagayawan (Tatarikan)"
  },
  #35
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Piagapo"
  },
  #36
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Picong (Sultan Gumander)"
  },
  #37
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Poona Bayabao (Gata)"
  },
  #38
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Pualas"
  },
  #39
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Saguiaran"
  },
  #40
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Sultan Dumalondong"
  },
  #41
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Tagoloan Ii"
  },
  #42
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Tamparan"
  },
  #43
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Taraka"
  },
  #44
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Tubaran"
  },
  #45
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Tugaya"
  },
  #46
  %{
    region: "ARMM",
    region_name: "",
    province: "Lanao Del Sur",
    city_municipal: "Wao"
  },
  #47
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Ampatuan"
  },
  #48
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Barira"
  },
  #49
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Buldon"
  },
  #50
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Buluan"
  },
  #51
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Datu Abdullah Sangki"
  },
  #52
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Datu Odin Sinsuat (Dinaig)"
  },
  #53
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Datu Paglas"
  },
  #54
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Datu Piang"
  },
  #55
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Datu Saudi-Ampatuan"
  },
  #56
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Datu Unsay"
  },
  #57
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Gen. S. K. Pendatun"
  },
  #58
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Guindulungan"
  },
  #59
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Kabuntalan (Tumbao)"
  },
  #60
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Mamasapano"
  },
  #61
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Matanog"
  },
  #62
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Pagagawan"
  },
  #63
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Pagalungan"
  },
  #64
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Paglat"
  },
  #65
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Parang"
  },
  #66
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Rajah Buayan"
  },
  #67
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Shariff Aguak (Maganoy)"
  },
  #68
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "South Upi"
  },
  #69
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Sultan Kudarat (Nuling)"
  },
  #70
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Sultan Mastura"
  },
  #71
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Sultan Sa Barongis (Lambayong)"
  },
  #72
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Talayan"
  },
  #73
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Talitay"
  },
  #74
  %{
    region: "ARMM",
    region_name: "",
    province: "Maguindanao",
    city_municipal: "Upi"
  },
  #75
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Hadji Panglima Tahil (Marunggas)"
  },
  #76
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Indanan"
  },
  #77
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Jolo"
  },
  #78
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Kalingalan Caluang"
  },
  #79
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Lugus"
  },
  #80
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Luuk"
  },
  #81
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Maimbung"
  },
  #82
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Old Panamao"
  },
  #83
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Pandami"
  },
  #84
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Panglima Estino (New Panamao)"
  },
  #85
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Pangutaran"
  },
  #86
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Parang"
  },
  #87
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Pata"
  },
  #88
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Patikul"
  },
  #89
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Siasi"
  },
  #90
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Talipao"
  },
  #91
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Tapul"
  },
  #92
  %{
    region: "ARMM",
    region_name: "",
    province: "Sulu",
    city_municipal: "Tongkil"
  },
  #93
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Bongao"
  },
  #94
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Languyan"
  },
  #95
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Mapun (Cagayan De Tawi-Tawi)"
  },
  #96
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Panglima Sugala (Balimbing)"
  },
  #97
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Sapa-Sapa"
  },
  #98
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Simunul"
  },
  #99
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Sitangkai"
  },
  #100
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "South Ubian"
  },
  #101
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Tandubas"
  },
  #102
  %{
    region: "ARMM",
    region_name: "",
    province: "Tawi-Tawi",
    city_municipal: "Turtle Islands"
  },
  #103
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Bangued"
  },
  #104
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Boliney"
  },
  #105
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Bucay"
  },
  #106
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Bucloc"
  },
  #107
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Daguioman"
  },
  #108
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Danglas"
  },
  #109
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Dolores"
  },
  #110
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "La Paz"
  },
  #111
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Lacub"
  },
  #112
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Lagangilang"
  },
  #113
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Lagayan"
  },
  #114
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Langiden"
  },
  #115
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Licuan-Baay (Licuan)"
  },
  #116
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Luba"
  },
  #117
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Malibcong"
  },
  #118
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Manabo"
  },
  #119
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Peñarrubia"
  },
  #120
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Pidigan"
  },
  #121
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Pilar"
  },
  #122
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Sallapadan"
  },
  #123
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "San Isidro"
  },
  #124
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "San Juan"
  },
  #125
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "San Quintin"
  },
  #126
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Tayum"
  },
  #127
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Tineg"
  },
  #128
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Tubo"
  },
  #129
  %{
    region: "CAR",
    region_name: "",
    province: "Abra",
    city_municipal: "Villaviciosa"
  },
  #130
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Calanasan (Bayag)"
  },
  #131
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Conner"
  },
  #132
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Flora"
  },
  #133
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Kabugao"
  },
  #134
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Luna"
  },
  #135
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Pudtol"
  },
  #136
  %{
    region: "CAR",
    region_name: "",
    province: "Apayao",
    city_municipal: "Santa Marcela"
  },
  #137
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Atok"
  },
  #138
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Baguio City"
  },
  #139
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Bakun"
  },
  #140
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Bokod"
  },
  #141
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Buguias"
  },
  #142
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Itogon"
  },
  #143
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Kabayan"
  },
  #144
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Kapangan"
  },
  #145
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Kibungan"
  },
  #146
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "La Trinidad"
  },
  #147
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Mankayan"
  },
  #148
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Sablan"
  },
  #149
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Tuba"
  },
  #150
  %{
    region: "CAR",
    region_name: "",
    province: "Benguet",
    city_municipal: "Tublay"
  },
  #151
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Aguinaldo"
  },
  #152
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Alfonso Lista (Potia)"
  },
  #153
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Asipulo"
  },
  #154
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Banaue"
  },
  #155
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Hingyon"
  },
  #156
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Hungduan"
  },
  #157
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Kiangan"
  },
  #158
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Lagawe"
  },
  #159
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Lamut"
  },
  #160
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Mayoyao"
  },
  #161
  %{
    region: "CAR",
    region_name: "",
    province: "Ifugao",
    city_municipal: "Tinoc"
  },
  #162
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Balbalan"
  },
  #163
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Lubuagan"
  },
  #164
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Pasil"
  },
  #165
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Pinukpuk"
  },
  #166
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Rizal (Liwan)"
  },
  #167
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Tabuk"
  },
  #168
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Tanudan"
  },
  #169
  %{
    region: "CAR",
    region_name: "",
    province: "Kalinga",
    city_municipal: "Tinglayan"
  },
  #170
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Barlig"
  },
  #171
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Bauko"
  },
  #172
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Besao"
  },
  #173
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Bontoc"
  },
  #174
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Natonin"
  },
  #175
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Paracelis"
  },
  #176
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Sabangan"
  },
  #177
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Sadanga"
  },
  #178
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Sagada"
  },
  #179
  %{
    region: "CAR",
    region_name: "",
    province: "Mountain Province",
    city_municipal: "Tadian"
  },
  #180
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Kalookan City"
  },
  #181
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Las Piñas City"
  },
  #182
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Makati City"
  },
  #183
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Malabon City"
  },
  #184
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Mandaluyong City"
  },
  #185
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Manila City"
  },
  #186
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Marikina City"
  },
  #187
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Muntinlupa City"
  },
  #188
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Navotas"
  },
  #189
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Parañaque City"
  },
  #190
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Pasay City"
  },
  #191
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Pasig City"
  },
  #192
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Pateros"
  },
  #193
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Quezon City"
  },
  #194
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "San Juan"
  },
  #195
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Taguig City"
  },
  #196
  %{
    region: "NCR",
    region_name: "",
    province: "Metro Manila",
    city_municipal: "Valenzuela City"
  },
  #197
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Adams"
  },
  #198
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Bacarra"
  },
  #199
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Badoc"
  },
  #200
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Bangui"
  },
  #201
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Banna (Espiritu)"
  },
  #202
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Batac"
  },
  #203
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Burgos"
  },
  #204
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Carasi"
  },
  #205
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Currimao"
  },
  #206
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Dingras"
  },
  #207
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Dumalneg"
  },
  #208
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Laoag City"
  },
  #209
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Marcos"
  },
  #210
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Nueva Era"
  },
  #211
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Pagudpud"
  },
  #212
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Paoay"
  },
  #213
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Pasuquin"
  },
  #214
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Piddig"
  },
  #215
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Pinili"
  },
  #216
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "San Nicolas"
  },
  #217
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Sarrat"
  },
  #218
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Solsona"
  },
  #219
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Norte",
    city_municipal: "Vintar"
  },
  #220
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Alilem"
  },
  #221
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Banayoyo"
  },
  #222
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Bantay"
  },
  #223
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Burgos"
  },
  #224
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Cabugao"
  },
  #225
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Candon City"
  },
  #226
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Caoayan"
  },
  #227
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Cervantes"
  },
  #228
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Galimuyod"
  },
  #229
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Gregorio Del Pilar (Concepcion)"
  },
  #230
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Lidlidda"
  },
  #231
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Magsingal"
  },
  #232
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Nagbukel"
  },
  #233
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Narvacan"
  },
  #234
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Quirino (Angkaki)"
  },
  #235
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Salcedo (Baugen)"
  },
  #236
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "San Emilio"
  },
  #237
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "San Esteban"
  },
  #238
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "San Ildefonso"
  },
  #239
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "San Juan (Lapog)"
  },
  #240
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "San Vicente"
  },
  #241
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santa"
  },
  #242
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santa Catalina"
  },
  #243
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santa Cruz"
  },
  #244
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santa Lucia"
  },
  #245
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santa Maria"
  },
  #246
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santiago"
  },
  #247
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Santo Domingo"
  },
  #248
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Sigay"
  },
  #249
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Sinait"
  },
  #250
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Sugpon"
  },
  #251
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Suyo"
  },
  #252
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Tagudin"
  },
  #253
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Ilocos Sur",
    city_municipal: "Vigan City"
  },
  #254
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Agoo"
  },
  #255
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Aringay"
  },
  #256
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Bacnotan"
  },
  #257
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Bagulin"
  },
  #258
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Balaoan"
  },
  #259
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Bangar"
  },
  #260
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Bauang"
  },
  #261
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Burgos"
  },
  #262
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Caba"
  },
  #263
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Luna"
  },
  #264
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Naguilian"
  },
  #265
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Pugo"
  },
  #266
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Rosario"
  },
  #267
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "San Fernando City"
  },
  #268
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "San Gabriel"
  },
  #269
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "San Juan"
  },
  #270
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Santo Tomas"
  },
  #271
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Santol"
  },
  #272
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Sudipen"
  },
  #273
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "La Union",
    city_municipal: "Tubao"
  },
  #274
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Agno"
  },
  #275
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Aguilar"
  },
  #276
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Alaminos City"
  },
  #277
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Alcala"
  },
  #278
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Anda"
  },
  #279
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Asingan"
  },
  #280
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Balungao"
  },
  #281
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Bani"
  },
  #282
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Basista"
  },
  #283
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Bautista"
  },
  #284
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Bayambang"
  },
  #285
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Binalonan"
  },
  #286
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Binmaley"
  },
  #287
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Bolinao"
  },
  #288
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Bugallon"
  },
  #289
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Burgos"
  },
  #290
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Calasiao"
  },
  #291
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Dagupan City"
  },
  #292
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Dasol"
  },
  #293
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Infanta"
  },
  #294
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Labrador"
  },
  #295
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Laoac"
  },
  #296
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Lingayen"
  },
  #297
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Mabini"
  },
  #298
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Malasiqui"
  },
  #299
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Manaoag"
  },
  #300
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Mangaldan"
  },
  #301
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Mangatarem"
  },
  #302
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Mapandan"
  },
  #303
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Natividad"
  },
  #304
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Pozzorubio"
  },
  #305
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Rosales"
  },
  #306
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "San Carlos City"
  },
  #307
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "San Fabian"
  },
  #308
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "San Jacinto"
  },
  #309
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "San Manuel"
  },
  #310
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "San Nicolas"
  },
  #311
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "San Quintin"
  },
  #312
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Santa Barbara"
  },
  #313
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Santa Maria"
  },
  #314
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Santo Tomas"
  },
  #315
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Sison"
  },
  #316
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Sual"
  },
  #317
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Tayug"
  },
  #318
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Umingan"
  },
  #319
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Urbiztondo"
  },
  #320
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Urdaneta City"
  },
  #321
  %{
    region: "REGION 1",
    region_name: "Ilocos Region",
    province: "Pangasinan",
    city_municipal: "Villasis"
  },
  #322
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Baungon"
  },
  #323
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Cabanglasan"
  },
  #324
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Damulog"
  },
  #325
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Dangcagan"
  },
  #326
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Don Carlos"
  },
  #327
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Impasug-Ong"
  },
  #328
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Kadingilan"
  },
  #329
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Kalilangan"
  },
  #330
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Kibawe"
  },
  #331
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Kitaotao"
  },
  #332
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Lantapan"
  },
  #333
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Libona"
  },
  #334
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Malaybalay City"
  },
  #335
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Malitbog"
  },
  #336
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Manolo Fortich"
  },
  #337
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Maramag"
  },
  #338
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Pangantucan"
  },
  #339
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Quezon"
  },
  #340
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "San Fernando"
  },
  #341
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Sumilao"
  },
  #342
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Talakag"
  },
  #343
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Bukidnon",
    city_municipal: "Valencia City"
  },
  #344
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Camiguin",
    city_municipal: "Catarman"
  },
  #345
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Camiguin",
    city_municipal: "Guinsiliban"
  },
  #346
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Camiguin",
    city_municipal: "Mahinog"
  },
  #347
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Camiguin",
    city_municipal: "Mambajao"
  },
  #348
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Camiguin",
    city_municipal: "Sagay"
  },
  #349
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Bacolod"
  },
  #350
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Baloi"
  },
  #351
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Baroy"
  },
  #352
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Iligan City"
  },
  #353
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Kapatagan"
  },
  #354
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Kauswagan"
  },
  #355
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Kolambugan"
  },
  #356
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Lala"
  },
  #357
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Linamon"
  },
  #358
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Magsaysay"
  },
  #359
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Maigo"
  },
  #360
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Matungao"
  },
  #361
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Munai"
  },
  #362
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Nunungan"
  },
  #363
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Pantao Ragat"
  },
  #364
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Pantar"
  },
  #365
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Poona Piagapo"
  },
  #366
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Salvador"
  },
  #367
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Sapad"
  },
  #368
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Sultan Naga Dimaporo (Karomatan)"
  },
  #369
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Tagoloan"
  },
  #370
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Tangcal"
  },
  #371
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Lanao Del Norte",
    city_municipal: "Tubod"
  },
  #372
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Aloran"
  },
  #373
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Baliangao"
  },
  #374
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Bonifacio"
  },
  #375
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Calamba"
  },
  #376
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Clarin"
  },
  #377
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Concepcion"
  },
  #378
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Don Victoriano Chiongbian (Don Mariano Marcos)"
  },
  #379
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Jimenez"
  },
  #380
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Lopez Jaena"
  },
  #381
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Oroquieta City"
  },
  #382
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Ozamis City"
  },
  #383
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Panaon"
  },
  #384
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Plaridel"
  },
  #385
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Sapang Dalaga"
  },
  #386
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Sinacaban"
  },
  #387
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Tangub City"
  },
  #388
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Occidental",
    city_municipal: "Tudela"
  },
  #389
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Alubijid"
  },
  #390
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Balingasag"
  },
  #391
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Balingoan"
  },
  #392
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Binuangan"
  },
  #393
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Cagayan De Oro City"
  },
  #394
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Claveria"
  },
  #395
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "El Salvador"
  },
  #396
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Gingoog City"
  },
  #397
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Gitagum"
  },
  #398
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Initao"
  },
  #399
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Jasaan"
  },
  #400
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Kinoguitan"
  },
  #401
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Lagonglong"
  },
  #402
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Laguindingan"
  },
  #403
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Libertad"
  },
  #404
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Lugait"
  },
  #405
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Magsaysay (Linugos)"
  },
  #406
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Manticao"
  },
  #407
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Medina"
  },
  #408
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Naawan"
  },
  #409
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Opol"
  },
  #410
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Salay"
  },
  #411
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Sugbongcogon"
  },
  #412
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Tagoloan"
  },
  #413
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Talisayan"
  },
  #414
  %{
    region: "REGION 10",
    region_name: "Northern Mindanao",
    province: "Misamis Oriental",
    city_municipal: "Villanueva"
  },
  #415
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Compostela"
  },
  #416
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Laak (San Vicente)"
  },
  #417
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Mabini (Doña Alicia)"
  },
  #418
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Maco"
  },
  #419
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Maragusan (San Mariano)"
  },
  #420
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Mawab"
  },
  #421
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Monkayo"
  },
  #422
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Montevista"
  },
  #423
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Nabunturan"
  },
  #424
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "New Bataan"
  },
  #425
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Compostela Valley",
    city_municipal: "Pantukan"
  },
  #426
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Asuncion (Saug)"
  },
  #427
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Braulio E. Dujali"
  },
  #428
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Carmen"
  },
  #429
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Island Garden City Of Samal"
  },
  #430
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Kapalong"
  },
  #431
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "New Corella"
  },
  #432
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Panabo City"
  },
  #433
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "San Isidro"
  },
  #434
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Santo Tomas"
  },
  #435
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Tagum City"
  },
  #436
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Norte",
    city_municipal: "Talaingod"
  },
  #437
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Bansalan"
  },
  #438
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Davao City"
  },
  #439
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Digos City"
  },
  #440
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Don Marcelino"
  },
  #441
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Hagonoy"
  },
  #442
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Jose Abad Santos (Trinidad)"
  },
  #443
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Kiblawan"
  },
  #444
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Magsaysay"
  },
  #445
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Malalag"
  },
  #446
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Malita"
  },
  #447
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Matanao"
  },
  #448
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Padada"
  },
  #449
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Santa Cruz"
  },
  #450
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Santa Maria"
  },
  #451
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Sarangani"
  },
  #452
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Del Sur",
    city_municipal: "Sulop"
  },
  #453
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Baganga"
  },
  #454
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Banaybanay"
  },
  #455
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Boston"
  },
  #456
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Caraga"
  },
  #457
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Cateel"
  },
  #458
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Governor Generoso"
  },
  #459
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Lupon"
  },
  #460
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Manay"
  },
  #461
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Mati"
  },
  #462
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "San Isidro"
  },
  #463
  %{
    region: "REGION 11",
    region_name: "Davao Region",
    province: "Davao Oriental",
    city_municipal: "Tarragona"
  },
  #464
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Alamada"
  },
  #465
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Aleosan"
  },
  #466
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Antipas"
  },
  #467
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Arakan"
  },
  #468
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Banisilan"
  },
  #469
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Carmen"
  },
  #470
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Cotabato City"
  },
  #471
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Kabacan"
  },
  #472
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Kidapawan City"
  },
  #473
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Libungan"
  },
  #474
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Magpet"
  },
  #475
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Makilala"
  },
  #476
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Matalam"
  },
  #477
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Midsayap"
  },
  #478
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "M'lang"
  },
  #479
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Pigkawayan"
  },
  #480
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Pikit"
  },
  #481
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "President Roxas"
  },
  #482
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Cotabato (North Cotabato)",
    city_municipal: "Tulunan"
  },
  #483
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Alabel"
  },
  #484
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Glan"
  },
  #485
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Kiamba"
  },
  #486
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Maasim"
  },
  #487
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Maitum"
  },
  #488
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Malapatan"
  },
  #489
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sarangani",
    city_municipal: "Malungon"
  },
  #490
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Banga"
  },
  #491
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "General Santos City (Dadiangas)"
  },
  #492
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Koronadal City"
  },
  #493
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Lake Sebu"
  },
  #494
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Norala"
  },
  #495
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Polomolok"
  },
  #496
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Santo Niño"
  },
  #497
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Surallah"
  },
  #498
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Tampakan"
  },
  #499
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Tantangan"
  },
  #500
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "T'boli"
  },
  #501
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "South Cotabato",
    city_municipal: "Tupi"
  },
  #502
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Bagumbayan"
  },
  #503
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Columbio"
  },
  #504
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Esperanza"
  },
  #505
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Isulan"
  },
  #506
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Kalamansig"
  },
  #507
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Lambayong (Mariano Marcos)"
  },
  #508
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Lebak"
  },
  #509
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Lutayan"
  },
  #510
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Palimbang"
  },
  #511
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "President Quirino"
  },
  #512
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Sen. Ninoy Aquino"
  },
  #513
  %{
    region: "REGION 12",
    region_name: "Soccsksargen",
    province: "Sultan Kudarat",
    city_municipal: "Tacurong City"
  },
  #514
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Buenavista"
  },
  #515
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Butuan City"
  },
  #516
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Cabadbaran"
  },
  #517
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Carmen"
  },
  #518
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Jabonga"
  },
  #519
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Kitcharao"
  },
  #520
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Las Nieves"
  },
  #521
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Magallanes"
  },
  #522
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Nasipit"
  },
  #523
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Remedios T. Romualdez"
  },
  #524
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Santiago"
  },
  #525
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Norte",
    city_municipal: "Tubay"
  },
  #526
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Bayugan"
  },
  #527
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Bunawan"
  },
  #528
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Esperanza"
  },
  #529
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "La Paz"
  },
  #530
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Loreto"
  },
  #531
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Prosperidad"
  },
  #532
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Rosario"
  },
  #533
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "San Francisco"
  },
  #534
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "San Luis"
  },
  #535
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Santa Josefa"
  },
  #536
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Sibagat"
  },
  #537
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Talacogon"
  },
  #538
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Trento"
  },
  #539
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Agusan Del Sur",
    city_municipal: "Veruela"
  },
  #540
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Alegria"
  },
  #541
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Bacuag"
  },
  #542
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Basilisa (Rizal)"
  },
  #543
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Burgos"
  },
  #544
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Cagdianao"
  },
  #545
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Claver"
  },
  #546
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Dapa"
  },
  #547
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Del Carmen"
  },
  #548
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Dinagat"
  },
  #549
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "General Luna"
  },
  #550
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Gigaquit"
  },
  #551
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Libjo (Albor)"
  },
  #552
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Loreto"
  },
  #553
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Mainit"
  },
  #554
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Malimono"
  },
  #555
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Pilar"
  },
  #556
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Placer"
  },
  #557
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "San Benito"
  },
  #558
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "San Francisco (Anao-Aon)"
  },
  #559
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "San Isidro"
  },
  #560
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "San Jose"
  },
  #561
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Santa Monica (Sapao)"
  },
  #562
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Sison"
  },
  #563
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Socorro"
  },
  #564
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Surigao City"
  },
  #565
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Tagana-An"
  },
  #566
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Tubajon"
  },
  #567
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Norte",
    city_municipal: "Tubod"
  },
  #568
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Barobo"
  },
  #569
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Bayabas"
  },
  #570
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Bislig City"
  },
  #571
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Cagwait"
  },
  #572
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Cantilan"
  },
  #573
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Carmen"
  },
  #574
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Carrascal"
  },
  #575
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Cortes"
  },
  #576
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Hinatuan"
  },
  #577
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Lanuza"
  },
  #578
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Lianga"
  },
  #579
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Lingig"
  },
  #580
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Madrid"
  },
  #581
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Marihatag"
  },
  #582
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "San Agustin"
  },
  #583
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "San Miguel"
  },
  #584
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Tagbina"
  },
  #585
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Tago"
  },
  #586
  %{
    region: "REGION 13",
    region_name: "CARAGA",
    province: "Surigao Del Sur",
    city_municipal: "Tandag"
  },
  #587
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Batanes",
    city_municipal: "Basco"
  },
  #588
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Batanes",
    city_municipal: "Itbayat"
  },
  #589
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Batanes",
    city_municipal: "Ivana"
  },
  #590
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Batanes",
    city_municipal: "Mahatao"
  },
  #591
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Batanes",
    city_municipal: "Sabtang"
  },
  #592
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Batanes",
    city_municipal: "Uyugan"
  },
  #593
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Abulug"
  },
  #594
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Alcala"
  },
  #595
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Allacapan"
  },
  #596
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Amulung"
  },
  #597
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Aparri"
  },
  #598
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Baggao"
  },
  #599
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Ballesteros"
  },
  #600
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Buguey"
  },
  #601
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Calayan"
  },
  #602
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Camalaniugan"
  },
  #603
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Claveria"
  },
  #604
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Enrile"
  },
  #605
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Gattaran"
  },
  #606
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Gonzaga"
  },
  #607
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Iguig"
  },
  #608
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Lal-Lo"
  },
  #609
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Lasam"
  },
  #610
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Pamplona"
  },
  #611
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Peñablanca"
  },
  #612
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Piat"
  },
  #613
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Rizal"
  },
  #614
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Sanchez-Mira"
  },
  #615
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Santa Ana"
  },
  #616
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Santa Praxedes"
  },
  #617
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Santa Teresita"
  },
  #618
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Santo Niño (Faire)"
  },
  #619
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Solana"
  },
  #620
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Tuao"
  },
  #621
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Cagayan",
    city_municipal: "Tuguegarao City"
  },
  #622
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Alicia"
  },
  #623
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Angadanan"
  },
  #624
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Aurora"
  },
  #625
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Benito Soliven"
  },
  #626
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Burgos"
  },
  #627
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Cabagan"
  },
  #628
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Cabatuan"
  },
  #629
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Cauayan City"
  },
  #630
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Cordon"
  },
  #631
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Delfin Albano (Magsaysay)"
  },
  #632
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Dinapigue"
  },
  #633
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Divilacan"
  },
  #634
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Echague"
  },
  #635
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Gamu"
  },
  #636
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Ilagan"
  },
  #637
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Jones"
  },
  #638
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Luna"
  },
  #639
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Maconacon"
  },
  #640
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Mallig"
  },
  #641
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Naguilian"
  },
  #642
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Palanan"
  },
  #643
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Quezon"
  },
  #644
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Quirino"
  },
  #645
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Ramon"
  },
  #646
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Reina Mercedes"
  },
  #647
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Roxas"
  },
  #648
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Agustin"
  },
  #649
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Guillermo"
  },
  #650
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Isidro"
  },
  #651
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Manuel"
  },
  #652
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Mariano"
  },
  #653
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Mateo"
  },
  #654
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "San Pablo"
  },
  #655
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Santa Maria"
  },
  #656
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Santiago City"
  },
  #657
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Santo Tomas"
  },
  #658
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Isabela",
    city_municipal: "Tumauini"
  },
  #659
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Alfonso Castaneda"
  },
  #660
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Ambaguio"
  },
  #661
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Aritao"
  },
  #662
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Bagabag"
  },
  #663
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Bambang"
  },
  #664
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Bayombong"
  },
  #665
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Diadi"
  },
  #666
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Dupax Del Norte"
  },
  #667
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Dupax Del Sur"
  },
  #668
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Kasibu"
  },
  #669
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Kayapa"
  },
  #670
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Quezon"
  },
  #671
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Santa Fe"
  },
  #672
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Solano"
  },
  #673
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Nueva Vizcaya",
    city_municipal: "Villaverde"
  },
  #674
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Quirino",
    city_municipal: "Aglipay"
  },
  #675
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Quirino",
    city_municipal: "Cabarroguis"
  },
  #676
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Quirino",
    city_municipal: "Diffun"
  },
  #677
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Quirino",
    city_municipal: "Maddela"
  },
  #678
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Quirino",
    city_municipal: "Nagtipunan"
  },
  #679
  %{
    region: "REGION 2",
    region_name: "Cagayan Valley",
    province: "Quirino",
    city_municipal: "Saguday"
  },
  #680
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Baler"
  },
  #681
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Casiguran"
  },
  #682
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Dilasag"
  },
  #683
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Dinalungan"
  },
  #684
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Dingalan"
  },
  #685
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Dipaculao"
  },
  #686
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "Maria Aurora"
  },
  #687
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Aurora",
    city_municipal: "San Luis"
  },
  #688
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Abucay"
  },
  #689
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Bagac"
  },
  #690
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Balanga City"
  },
  #691
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Dinalupihan"
  },
  #692
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Hermosa"
  },
  #693
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Limay"
  },
  #694
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Mariveles"
  },
  #695
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Morong"
  },
  #696
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Orani"
  },
  #697
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Orion"
  },
  #698
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Pilar"
  },
  #699
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bataan",
    city_municipal: "Samal"
  },
  #700
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Angat"
  },
  #701
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Balagtas (Bigaa)"
  },
  #702
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Baliuag"
  },
  #703
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Bocaue"
  },
  #704
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Bulacan"
  },
  #705
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Bustos"
  },
  #706
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Calumpit"
  },
  #707
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Doña Remedios Trinidad"
  },
  #708
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Guiguinto"
  },
  #709
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Hagonoy"
  },
  #710
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Malolos City"
  },
  #711
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Marilao"
  },
  #712
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Meycauayan"
  },
  #713
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Norzagaray"
  },
  #714
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Obando"
  },
  #715
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Pandi"
  },
  #716
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Paombong"
  },
  #717
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Plaridel"
  },
  #718
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Pulilan"
  },
  #719
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "San Ildefonso"
  },
  #720
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "San Jose Del Monte City"
  },
  #721
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "San Miguel"
  },
  #722
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "San Rafael"
  },
  #723
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Bulacan",
    city_municipal: "Santa Maria"
  },
  #724
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Aliaga"
  },
  #725
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Bongabon"
  },
  #726
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Cabanatuan City"
  },
  #727
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Cabiao"
  },
  #728
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Carranglan"
  },
  #729
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Cuyapo"
  },
  #730
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Gabaldon (Bitulok & Sabani)"
  },
  #731
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Gapan City"
  },
  #732
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "General Mamerto Natividad"
  },
  #733
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "General Tinio (Papaya)"
  },
  #734
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Guimba"
  },
  #735
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Jaen"
  },
  #736
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Laur"
  },
  #737
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Licab"
  },
  #738
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Llanera"
  },
  #739
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Lupao"
  },
  #740
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Muñoz"
  },
  #741
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Nampicuan"
  },
  #742
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Palayan City"
  },
  #743
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Pantabangan"
  },
  #744
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Peñaranda"
  },
  #745
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Quezon"
  },
  #746
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Rizal"
  },
  #747
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "San Antonio"
  },
  #748
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "San Isidro"
  },
  #749
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "San Jose City"
  },
  #750
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "San Leonardo"
  },
  #751
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Santa Rosa"
  },
  #752
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Santo Domingo"
  },
  #753
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Science City Of Muñoz"
  },
  #754
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Talavera"
  },
  #755
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Talugtug"
  },
  #756
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Nueva Ecija",
    city_municipal: "Zaragoza"
  },
  #757
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Angeles City"
  },
  #758
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Apalit"
  },
  #759
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Arayat"
  },
  #760
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Bacolor"
  },
  #761
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Candaba"
  },
  #762
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Floridablanca"
  },
  #763
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Guagua"
  },
  #764
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Lubao"
  },
  #765
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Mabalacat"
  },
  #766
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Macabebe"
  },
  #767
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Magalang"
  },
  #768
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Masantol"
  },
  #769
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Mexico"
  },
  #770
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Minalin"
  },
  #771
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Porac"
  },
  #772
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "San Fernando City"
  },
  #773
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "San Luis"
  },
  #774
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "San Simon"
  },
  #775
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Santa Ana"
  },
  #776
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Santa Rita"
  },
  #777
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Santo Tomas"
  },
  #778
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Pampanga",
    city_municipal: "Sasmuan (Sexmoan)"
  },
  #779
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Anao"
  },
  #780
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Bamban"
  },
  #781
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Camiling"
  },
  #782
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Capas"
  },
  #783
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Concepcion"
  },
  #784
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Gerona"
  },
  #785
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "La Paz"
  },
  #786
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Mayantoc"
  },
  #787
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Moncada"
  },
  #788
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Paniqui"
  },
  #789
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Pura"
  },
  #790
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Ramos"
  },
  #791
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "San Clemente"
  },
  #792
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "San Jose"
  },
  #793
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "San Manuel"
  },
  #794
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "San Miguel"
  },
  #795
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Santa Ignacia"
  },
  #796
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Tarlac City"
  },
  #797
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Tarlac",
    city_municipal: "Victoria"
  },
  #798
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Botolan"
  },
  #799
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Cabangan"
  },
  #800
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Candelaria"
  },
  #801
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Castillejos"
  },
  #802
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Iba"
  },
  #803
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Masinloc"
  },
  #804
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Olongapo City"
  },
  #805
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Palauig"
  },
  #806
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "San Antonio"
  },
  #807
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "San Felipe"
  },
  #808
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "San Marcelino"
  },
  #809
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "San Narciso"
  },
  #810
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Santa Cruz"
  },
  #811
  %{
    region: "REGION 3",
    region_name: "Central Luzon",
    province: "Zambales",
    city_municipal: "Subic"
  },
  #812
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Agoncillo"
  },
  #813
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Alitagtag"
  },
  #814
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Balayan"
  },
  #815
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Balete"
  },
  #816
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Batangas City"
  },
  #817
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Bauan"
  },
  #818
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Calaca"
  },
  #819
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Calatagan"
  },
  #820
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Cuenca"
  },
  #821
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Ibaan"
  },
  #822
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Laurel"
  },
  #823
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Lemery"
  },
  #824
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Lian"
  },
  #825
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Lipa City"
  },
  #826
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Lobo"
  },
  #827
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Mabini"
  },
  #828
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Malvar"
  },
  #829
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Mataas Na Kahoy"
  },
  #830
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Nasugbu"
  },
  #831
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Padre Garcia"
  },
  #832
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Rosario"
  },
  #833
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "San Jose"
  },
  #834
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "San Juan"
  },
  #835
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "San Luis"
  },
  #836
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "San Nicolas"
  },
  #837
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "San Pascual"
  },
  #838
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Santa Teresita"
  },
  #839
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Santo Tomas"
  },
  #840
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Taal"
  },
  #841
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Talisay"
  },
  #842
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Tanauan City"
  },
  #843
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Taysan"
  },
  #844
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Tingloy"
  },
  #845
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Batangas",
    city_municipal: "Tuy"
  },
  #846
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Alfonso"
  },
  #847
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Amadeo"
  },
  #848
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Bacoor"
  },
  #849
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Carmona"
  },
  #850
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Cavite City"
  },
  #851
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Dasmariñas"
  },
  #852
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Gen. Mariano Alvarez"
  },
  #853
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "General Emilio Aguinaldo"
  },
  #854
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "General Trias"
  },
  #855
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Imus"
  },
  #856
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Indang"
  },
  #857
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Kawit"
  },
  #858
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Magallanes"
  },
  #859
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Maragondon"
  },
  #860
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Mendez (Mendez-Nuñez)"
  },
  #861
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Naic"
  },
  #862
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Noveleta"
  },
  #863
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Rosario"
  },
  #864
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Silang"
  },
  #865
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Tagaytay City"
  },
  #866
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Tanza"
  },
  #867
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Ternate"
  },
  #868
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Cavite",
    city_municipal: "Trece Martires City"
  },
  #869
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Alaminos"
  },
  #870
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Bay"
  },
  #871
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Biñan"
  },
  #872
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Cabuyao"
  },
  #873
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Calamba City"
  },
  #874
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Calauan"
  },
  #875
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Canlubang"
  },
  #876
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Cavinti"
  },
  #877
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Famy"
  },
  #878
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Kalayaan"
  },
  #879
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Liliw"
  },
  #880
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Los Baños"
  },
  #881
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Luisiana"
  },
  #882
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Lumban"
  },
  #883
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Mabitac"
  },
  #884
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Magdalena"
  },
  #885
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Majayjay"
  },
  #886
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Nagcarlan"
  },
  #887
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Paete"
  },
  #888
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Pagsanjan"
  },
  #889
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Pakil"
  },
  #890
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Pangil"
  },
  #891
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Pila"
  },
  #892
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Rizal"
  },
  #893
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "San Pablo City"
  },
  #894
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "San Pedro"
  },
  #895
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Santa Cruz"
  },
  #896
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Santa Maria"
  },
  #897
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Santa Rosa City"
  },
  #898
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Siniloan"
  },
  #899
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Laguna",
    city_municipal: "Victoria"
  },
  #900
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Agdangan"
  },
  #901
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Alabat"
  },
  #902
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Atimonan"
  },
  #903
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Buenavista"
  },
  #904
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Burdeos"
  },
  #905
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Calauag"
  },
  #906
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Candelaria"
  },
  #907
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Catanauan"
  },
  #908
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Dolores"
  },
  #909
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "General Luna"
  },
  #910
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "General Nakar"
  },
  #911
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Guinayangan"
  },
  #912
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Gumaca"
  },
  #913
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Infanta"
  },
  #914
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Jomalig"
  },
  #915
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Lopez"
  },
  #916
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Lucban"
  },
  #917
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Lucena City"
  },
  #918
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Macalelon"
  },
  #919
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Mauban"
  },
  #920
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Mulanay"
  },
  #921
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Padre Burgos"
  },
  #922
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Pagbilao"
  },
  #923
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Panukulan"
  },
  #924
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Patnanungan"
  },
  #925
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Perez"
  },
  #926
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Pitogo"
  },
  #927
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Plaridel"
  },
  #928
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Polillo"
  },
  #929
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Quezon"
  },
  #930
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Real"
  },
  #931
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Sampaloc"
  },
  #932
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "San Andres"
  },
  #933
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "San Antonio"
  },
  #934
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "San Francisco (Aurora)"
  },
  #935
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "San Narciso"
  },
  #936
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Sariaya"
  },
  #937
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Tagkawayan"
  },
  #938
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Tayabas"
  },
  #939
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Tiaong"
  },
  #940
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Quezon",
    city_municipal: "Unisan"
  },
  #941
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Angono"
  },
  #942
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Antipolo City"
  },
  #943
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Baras"
  },
  #944
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Binangonan"
  },
  #945
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Cainta"
  },
  #946
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Cardona"
  },
  #947
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Jala-Jala"
  },
  #948
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Morong"
  },
  #949
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Pililla"
  },
  #950
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Rodriguez (Montalban)"
  },
  #951
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "San Mateo"
  },
  #952
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Tanay"
  },
  #953
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Taytay"
  },
  #954
  %{
    region: "REGION 4-A",
    region_name: "CALABARZON",
    province: "Rizal",
    city_municipal: "Teresa"
  },
  #955
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Marinduque",
    city_municipal: "Boac"
  },
  #956
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Marinduque",
    city_municipal: "Buenavista"
  },
  #957
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Marinduque",
    city_municipal: "Gasan"
  },
  #958
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Marinduque",
    city_municipal: "Mogpog"
  },
  #959
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Marinduque",
    city_municipal: "Santa Cruz"
  },
  #960
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Marinduque",
    city_municipal: "Torrijos"
  },
  #961
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Abra De Ilog"
  },
  #962
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Calintaan"
  },
  #963
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Looc"
  },
  #964
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Lubang"
  },
  #965
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Magsaysay"
  },
  #966
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Mamburao"
  },
  #967
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Paluan"
  },
  #968
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Rizal"
  },
  #969
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Sablayan"
  },
  #970
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "San Jose"
  },
  #971
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Occidental Mindoro",
    city_municipal: "Santa Cruz"
  },
  #972
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Baco"
  },
  #973
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Bansud"
  },
  #974
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Bongabong"
  },
  #975
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Bulalacao (San Pedro)"
  },
  #976
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Calapan City"
  },
  #977
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Gloria"
  },
  #978
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Mansalay"
  },
  #979
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Naujan"
  },
  #980
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Pinamalayan"
  },
  #981
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Pola"
  },
  #982
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Puerto Galera"
  },
  #983
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Roxas"
  },
  #984
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "San Teodoro"
  },
  #985
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Socorro"
  },
  #986
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Oriental Mindoro",
    city_municipal: "Victoria"
  },
  #987
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Aborlan"
  },
  #988
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Agutaya"
  },
  #989
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Araceli"
  },
  #990
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Balabac"
  },
  #991
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Bataraza"
  },
  #992
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Brooke's Point"
  },
  #993
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Busuanga"
  },
  #994
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Cagayancillo"
  },
  #995
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Coron"
  },
  #996
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Culion"
  },
  #997
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Cuyo"
  },
  #998
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Dumaran"
  },
  #999
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "El Nido (Bacuit)"
  },
  #1000
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Kalayaan"
  },
  #1001
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Linapacan"
  },
  #1002
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Magsaysay"
  },
  #1003
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Narra"
  },
  #1004
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Puerto Princesa City"
  },
  #1005
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Quezon"
  },
  #1006
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Rizal (Marcos)"
  },
  #1007
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Roxas"
  },
  #1008
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "San Vicente"
  },
  #1009
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Sofronio Española"
  },
  #1010
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Palawan",
    city_municipal: "Taytay"
  },
  #1011
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Alcantara"
  },
  #1012
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Banton"
  },
  #1013
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Cajidiocan"
  },
  #1014
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Calatrava"
  },
  #1015
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Concepcion"
  },
  #1016
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Corcuera"
  },
  #1017
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Ferrol"
  },
  #1018
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Looc"
  },
  #1019
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Magdiwang"
  },
  #1020
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Odiongan"
  },
  #1021
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Romblon"
  },
  #1022
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "San Agustin"
  },
  #1023
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "San Andres"
  },
  #1024
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "San Fernando"
  },
  #1025
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "San Jose"
  },
  #1026
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Santa Fe"
  },
  #1027
  %{
    region: "REGION 4-B",
    region_name: "MIMAROPA",
    province: "Romblon",
    city_municipal: "Santa Maria (Imelda)"
  },
  #1028
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Bacacay"
  },
  #1029
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Camalig"
  },
  #1030
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Daraga (Locsin)"
  },
  #1031
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Guinobatan"
  },
  #1032
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Jovellar"
  },
  #1033
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Legazpi City"
  },
  #1034
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Libon"
  },
  #1035
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Ligao City"
  },
  #1036
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Malilipot"
  },
  #1037
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Malinao"
  },
  #1038
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Manito"
  },
  #1039
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Oas"
  },
  #1040
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Pio Duran"
  },
  #1041
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Polangui"
  },
  #1042
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Rapu-Rapu"
  },
  #1043
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Santo Domingo (Libog)"
  },
  #1044
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Tabaco City"
  },
  #1045
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Albay",
    city_municipal: "Tiwi"
  },
  #1046
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Basud"
  },
  #1047
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Capalonga"
  },
  #1048
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Daet"
  },
  #1049
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Jose Panganiban"
  },
  #1050
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Labo"
  },
  #1051
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Mercedes"
  },
  #1052
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Paracale"
  },
  #1053
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "San Lorenzo Ruiz (Imelda)"
  },
  #1054
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "San Vicente"
  },
  #1055
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Santa Elena"
  },
  #1056
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Talisay"
  },
  #1057
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Norte",
    city_municipal: "Vinzons"
  },
  #1058
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Baao"
  },
  #1059
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Balatan"
  },
  #1060
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Bato"
  },
  #1061
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Bombon"
  },
  #1062
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Buhi"
  },
  #1063
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Bula"
  },
  #1064
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Cabusao"
  },
  #1065
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Calabanga"
  },
  #1066
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Camaligan"
  },
  #1067
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Canaman"
  },
  #1068
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Caramoan"
  },
  #1069
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Del Gallego"
  },
  #1070
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Gainza"
  },
  #1071
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Garchitorena"
  },
  #1072
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Goa"
  },
  #1073
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Iriga City"
  },
  #1074
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Lagonoy"
  },
  #1075
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Libmanan"
  },
  #1076
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Lupi"
  },
  #1077
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Magarao"
  },
  #1078
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Milaor"
  },
  #1079
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Minalabac"
  },
  #1080
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Nabua"
  },
  #1081
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Naga City"
  },
  #1082
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Ocampo"
  },
  #1083
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Pamplona"
  },
  #1084
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Pasacao"
  },
  #1085
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Pili"
  },
  #1086
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Presentacion (Parubcan)"
  },
  #1087
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Ragay"
  },
  #1088
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Sagñay"
  },
  #1089
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "San Fernando"
  },
  #1090
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "San Jose"
  },
  #1091
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Sipocot"
  },
  #1092
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Siruma"
  },
  #1093
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Tigaon"
  },
  #1094
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Camarines Sur",
    city_municipal: "Tinambac"
  },
  #1095
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Bagamanoc"
  },
  #1096
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Baras"
  },
  #1097
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Bato"
  },
  #1098
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Caramoran"
  },
  #1099
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Gigmoto"
  },
  #1100
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Pandan"
  },
  #1101
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Panganiban (Payo)"
  },
  #1102
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "San Andres (Calolbon)"
  },
  #1103
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "San Miguel"
  },
  #1104
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Viga"
  },
  #1105
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Catanduanes",
    city_municipal: "Virac"
  },
  #1106
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Aroroy"
  },
  #1107
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Baleno"
  },
  #1108
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Balud"
  },
  #1109
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Batuan"
  },
  #1110
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Cataingan"
  },
  #1111
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Cawayan"
  },
  #1112
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Claveria"
  },
  #1113
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Dimasalang"
  },
  #1114
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Esperanza"
  },
  #1115
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Mandaon"
  },
  #1116
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Masbate City"
  },
  #1117
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Milagros"
  },
  #1118
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Mobo"
  },
  #1119
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Monreal"
  },
  #1120
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Palanas"
  },
  #1121
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Pio V. Corpuz (Limbuhan)"
  },
  #1122
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Placer"
  },
  #1123
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "San Fernando"
  },
  #1124
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "San Jacinto"
  },
  #1125
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "San Pascual"
  },
  #1126
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Masbate",
    city_municipal: "Uson"
  },
  #1127
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Barcelona"
  },
  #1128
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Bulan"
  },
  #1129
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Bulusan"
  },
  #1130
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Casiguran"
  },
  #1131
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Castilla"
  },
  #1132
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Donsol"
  },
  #1133
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Gubat"
  },
  #1134
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Irosin"
  },
  #1135
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Juban"
  },
  #1136
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Magallanes"
  },
  #1137
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Matnog"
  },
  #1138
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Pilar"
  },
  #1139
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Prieto Diaz"
  },
  #1140
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Santa Magdalena"
  },
  #1141
  %{
    region: "REGION 5",
    region_name: "Bicol Region",
    province: "Sorsogon",
    city_municipal: "Sorsogon City"
  },
  #1142
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Altavas"
  },
  #1143
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Balete"
  },
  #1144
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Banga"
  },
  #1145
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Batan"
  },
  #1146
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Buruanga"
  },
  #1147
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Ibajay"
  },
  #1148
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Kalibo"
  },
  #1149
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Lezo"
  },
  #1150
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Libacao"
  },
  #1151
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Madalag"
  },
  #1152
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Makato"
  },
  #1153
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Malay"
  },
  #1154
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Malinao"
  },
  #1155
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Nabas"
  },
  #1156
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "New Washington"
  },
  #1157
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Numancia"
  },
  #1158
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Aklan",
    city_municipal: "Tangalan"
  },
  #1159
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Anini-Y"
  },
  #1160
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Barbaza"
  },
  #1161
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Belison"
  },
  #1162
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Bugasong"
  },
  #1163
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Caluya"
  },
  #1164
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Culasi"
  },
  #1165
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Hamtic"
  },
  #1166
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Laua-An"
  },
  #1167
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Libertad"
  },
  #1168
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Pandan"
  },
  #1169
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Patnongon"
  },
  #1170
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "San Jose"
  },
  #1171
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "San Remigio"
  },
  #1172
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Sebaste"
  },
  #1173
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Sibalom"
  },
  #1174
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Tibiao"
  },
  #1175
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Tobias Fornier (Dao)"
  },
  #1176
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Antique",
    city_municipal: "Valderrama"
  },
  #1177
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Cuartero"
  },
  #1178
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Dao"
  },
  #1179
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Dumalag"
  },
  #1180
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Dumarao"
  },
  #1181
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Ivisan"
  },
  #1182
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Jamindan"
  },
  #1183
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Ma-Ayon"
  },
  #1184
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Mambusao"
  },
  #1185
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Panay"
  },
  #1186
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Panitan"
  },
  #1187
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Pilar"
  },
  #1188
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Pontevedra"
  },
  #1189
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "President Roxas"
  },
  #1190
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Roxas City"
  },
  #1191
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Sapi-An"
  },
  #1192
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Sigma"
  },
  #1193
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Capiz",
    city_municipal: "Tapaz"
  },
  #1194
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Guimaras",
    city_municipal: "Buenavista"
  },
  #1195
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Guimaras",
    city_municipal: "Jordan"
  },
  #1196
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Guimaras",
    city_municipal: "Nueva Valencia"
  },
  #1197
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Guimaras",
    city_municipal: "San Lorenzo"
  },
  #1198
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Guimaras",
    city_municipal: "Sibunag"
  },
  #1199
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Ajuy"
  },
  #1200
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Alimodian"
  },
  #1201
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Anilao"
  },
  #1202
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Badiangan"
  },
  #1203
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Balasan"
  },
  #1204
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Banate"
  },
  #1205
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Barotac Nuevo"
  },
  #1206
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Barotac Viejo"
  },
  #1207
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Batad"
  },
  #1208
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Bingawan"
  },
  #1209
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Cabatuan"
  },
  #1210
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Calinog"
  },
  #1211
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Carles"
  },
  #1212
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Concepcion"
  },
  #1213
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Dingle"
  },
  #1214
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Dueñas"
  },
  #1215
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Dumangas"
  },
  #1216
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Estancia"
  },
  #1217
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Guimbal"
  },
  #1218
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Igbaras"
  },
  #1219
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Iloilo City"
  },
  #1220
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Janiuay"
  },
  #1221
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Lambunao"
  },
  #1222
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Leganes"
  },
  #1223
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Lemery"
  },
  #1224
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Leon"
  },
  #1225
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Maasin"
  },
  #1226
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Miagao"
  },
  #1227
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Mina"
  },
  #1228
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "New Lucena"
  },
  #1229
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Oton"
  },
  #1230
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Passi City"
  },
  #1231
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Pavia"
  },
  #1232
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Pototan"
  },
  #1233
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "San Dionisio"
  },
  #1234
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "San Enrique"
  },
  #1235
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "San Joaquin"
  },
  #1236
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "San Miguel"
  },
  #1237
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "San Rafael"
  },
  #1238
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Santa Barbara"
  },
  #1239
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Sara"
  },
  #1240
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Tigbauan"
  },
  #1241
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Tubungan"
  },
  #1242
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Iloilo",
    city_municipal: "Zarraga"
  },
  #1243
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Bacolod City"
  },
  #1244
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Bago City"
  },
  #1245
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Binalbagan"
  },
  #1246
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Cadiz City"
  },
  #1247
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Calatrava"
  },
  #1248
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Candoni"
  },
  #1249
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Cauayan"
  },
  #1250
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Enrique B. Magalona (Saravia)"
  },
  #1251
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Escalante City"
  },
  #1252
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Himamaylan City"
  },
  #1253
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Hinigaran"
  },
  #1254
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Hinoba-An (Asia)"
  },
  #1255
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Ilog"
  },
  #1256
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Isabela"
  },
  #1257
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Kabankalan City"
  },
  #1258
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "La Carlota City"
  },
  #1259
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "La Castellana"
  },
  #1260
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Manapla"
  },
  #1261
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Moises Padilla (Magallon)"
  },
  #1262
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Murcia"
  },
  #1263
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Pontevedra"
  },
  #1264
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Pulupandan"
  },
  #1265
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Sagay City"
  },
  #1266
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Salvador Benedicto"
  },
  #1267
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "San Carlos City"
  },
  #1268
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "San Enrique"
  },
  #1269
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Silay City"
  },
  #1270
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Sipalay City"
  },
  #1271
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Talisay City"
  },
  #1272
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Toboso"
  },
  #1273
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Valladolid"
  },
  #1274
  %{
    region: "REGION 6",
    region_name: "Western Visayas",
    province: "Negros Occidental",
    city_municipal: "Victorias City"
  },
  #1275
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Alburquerque"
  },
  #1276
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Alicia"
  },
  #1277
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Anda"
  },
  #1278
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Antequera"
  },
  #1279
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Baclayon"
  },
  #1280
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Balilihan"
  },
  #1281
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Batuan"
  },
  #1282
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Bien Unido"
  },
  #1283
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Bilar"
  },
  #1284
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Buenavista"
  },
  #1285
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Calape"
  },
  #1286
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Candijay"
  },
  #1287
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Carmen"
  },
  #1288
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Catigbian"
  },
  #1289
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Clarin"
  },
  #1290
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Corella"
  },
  #1291
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Cortes"
  },
  #1292
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Dagohoy"
  },
  #1293
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Danao"
  },
  #1294
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Dauis"
  },
  #1295
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Dimiao"
  },
  #1296
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Duero"
  },
  #1297
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Garcia Hernandez"
  },
  #1298
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Guindulman"
  },
  #1299
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Inabanga"
  },
  #1300
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Jagna"
  },
  #1301
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Jetafe"
  },
  #1302
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Lila"
  },
  #1303
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Loay"
  },
  #1304
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Loboc"
  },
  #1305
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Loon"
  },
  #1306
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Mabini"
  },
  #1307
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Maribojoc"
  },
  #1308
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Panglao"
  },
  #1309
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Pilar"
  },
  #1310
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Pres. Carlos P. Garcia (Pitogo)"
  },
  #1311
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Sagbayan (Borja)"
  },
  #1312
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "San Isidro"
  },
  #1313
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "San Miguel"
  },
  #1314
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Sevilla"
  },
  #1315
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Sierra Bullones"
  },
  #1316
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Sikatuna"
  },
  #1317
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Tagbilaran City"
  },
  #1318
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Talibon"
  },
  #1319
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Trinidad"
  },
  #1320
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Tubigon"
  },
  #1321
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Ubay"
  },
  #1322
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Bohol",
    city_municipal: "Valencia"
  },
  #1323
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Alcantara"
  },
  #1324
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Alcoy"
  },
  #1325
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Alegria"
  },
  #1326
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Aloguinsan"
  },
  #1327
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Argao"
  },
  #1328
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Asturias"
  },
  #1329
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Badian"
  },
  #1330
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Balamban"
  },
  #1331
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Bantayan"
  },
  #1332
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Barili"
  },
  #1333
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Bogo"
  },
  #1334
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Boljoon"
  },
  #1335
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Borbon"
  },
  #1336
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Carcar"
  },
  #1337
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Carmen"
  },
  #1338
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Catmon"
  },
  #1339
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Cebu City"
  },
  #1340
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Compostela"
  },
  #1341
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Consolacion"
  },
  #1342
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Cordoba"
  },
  #1343
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Daanbantayan"
  },
  #1344
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Dalaguete"
  },
  #1345
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Danao City"
  },
  #1346
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Dumanjug"
  },
  #1347
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Ginatilan"
  },
  #1348
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Lapu-Lapu City (Opon)"
  },
  #1349
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Liloan"
  },
  #1350
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Madridejos"
  },
  #1351
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Malabuyoc"
  },
  #1352
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Mandaue City"
  },
  #1353
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Medellin"
  },
  #1354
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Minglanilla"
  },
  #1355
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Moalboal"
  },
  #1356
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Naga"
  },
  #1357
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Oslob"
  },
  #1358
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Pilar"
  },
  #1359
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Pinamungahan"
  },
  #1360
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Poro"
  },
  #1361
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Ronda"
  },
  #1362
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Samboan"
  },
  #1363
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "San Fernando"
  },
  #1364
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "San Francisco"
  },
  #1365
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "San Remigio"
  },
  #1366
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Santa Fe"
  },
  #1367
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Santander"
  },
  #1368
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Sibonga"
  },
  #1369
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Sogod"
  },
  #1370
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Tabogon"
  },
  #1371
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Tabuelan"
  },
  #1372
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Talisay City"
  },
  #1373
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Toledo City"
  },
  #1374
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Tuburan"
  },
  #1375
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Cebu",
    city_municipal: "Tudela"
  },
  #1376
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Amlan (Ayuquitan)"
  },
  #1377
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Ayungon"
  },
  #1378
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Bacong"
  },
  #1379
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Bais City"
  },
  #1380
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Basay"
  },
  #1381
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Bayawan (Tulong) City"
  },
  #1382
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Bindoy (Payabon)"
  },
  #1383
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Canlaon City"
  },
  #1384
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Dauin"
  },
  #1385
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Dumaguete City"
  },
  #1386
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Guihulngan"
  },
  #1387
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Jimalalud"
  },
  #1388
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "La Libertad"
  },
  #1389
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Mabinay"
  },
  #1390
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Manjuyod"
  },
  #1391
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Pamplona"
  },
  #1392
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "San Jose"
  },
  #1393
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Santa Catalina"
  },
  #1394
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Siaton"
  },
  #1395
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Sibulan"
  },
  #1396
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Tanjay City"
  },
  #1397
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Tayasan"
  },
  #1398
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Valencia (Luzurriaga)"
  },
  #1399
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Vallehermoso"
  },
  #1400
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Negros Oriental",
    city_municipal: "Zamboanguita"
  },
  #1401
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Siquijor",
    city_municipal: "Enrique Villanueva"
  },
  #1402
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Siquijor",
    city_municipal: "Larena"
  },
  #1403
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Siquijor",
    city_municipal: "Lazi"
  },
  #1404
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Siquijor",
    city_municipal: "Maria"
  },
  #1405
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Siquijor",
    city_municipal: "San Juan"
  },
  #1406
  %{
    region: "REGION 7",
    region_name: "Central Visayas",
    province: "Siquijor",
    city_municipal: "Siquijor"
  },
  #1407
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Almeria"
  },
  #1408
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Biliran"
  },
  #1409
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Cabucgayan"
  },
  #1410
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Caibiran"
  },
  #1411
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Culaba"
  },
  #1412
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Kawayan"
  },
  #1413
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Maripipi"
  },
  #1414
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Biliran",
    city_municipal: "Naval"
  },
  #1415
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Arteche"
  },
  #1416
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Balangiga"
  },
  #1417
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Balangkayan"
  },
  #1418
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Borongan"
  },
  #1419
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Can-Avid"
  },
  #1420
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Dolores"
  },
  #1421
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "General Macarthur"
  },
  #1422
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Giporlos"
  },
  #1423
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Guiuan"
  },
  #1424
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Hernani"
  },
  #1425
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Jipapad"
  },
  #1426
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Lawaan"
  },
  #1427
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Llorente"
  },
  #1428
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Maslog"
  },
  #1429
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Maydolong"
  },
  #1430
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Mercedes"
  },
  #1431
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Oras"
  },
  #1432
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Quinapondan"
  },
  #1433
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Salcedo"
  },
  #1434
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "San Julian"
  },
  #1435
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "San Policarpo"
  },
  #1436
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Sulat"
  },
  #1437
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Eastern Samar",
    city_municipal: "Taft"
  },
  #1438
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Abuyog"
  },
  #1439
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Alangalang"
  },
  #1440
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Albuera"
  },
  #1441
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Babatngon"
  },
  #1442
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Barugo"
  },
  #1443
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Bato"
  },
  #1444
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Baybay"
  },
  #1445
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Burauen"
  },
  #1446
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Calubian"
  },
  #1447
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Capoocan"
  },
  #1448
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Carigara"
  },
  #1449
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Dagami"
  },
  #1450
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Dulag"
  },
  #1451
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Hilongos"
  },
  #1452
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Hindang"
  },
  #1453
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Inopacan"
  },
  #1454
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Isabel"
  },
  #1455
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Jaro"
  },
  #1456
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Javier (Bugho)"
  },
  #1457
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Julita"
  },
  #1458
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Kananga"
  },
  #1459
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "La Paz"
  },
  #1460
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Leyte"
  },
  #1461
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Macarthur"
  },
  #1462
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Mahaplag"
  },
  #1463
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Matag-Ob"
  },
  #1464
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Matalom"
  },
  #1465
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Mayorga"
  },
  #1466
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Merida"
  },
  #1467
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Ormoc City"
  },
  #1468
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Palo"
  },
  #1469
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Palompon"
  },
  #1470
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Pastrana"
  },
  #1471
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "San Isidro"
  },
  #1472
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "San Miguel"
  },
  #1473
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Santa Fe"
  },
  #1474
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Tabango"
  },
  #1475
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Tabontabon"
  },
  #1476
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Tacloban City"
  },
  #1477
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Tanauan"
  },
  #1478
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Tolosa"
  },
  #1479
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Tunga"
  },
  #1480
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Leyte",
    city_municipal: "Villaba"
  },
  #1481
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Allen"
  },
  #1482
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Biri"
  },
  #1483
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Bobon"
  },
  #1484
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Capul"
  },
  #1485
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Catarman"
  },
  #1486
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Catubig"
  },
  #1487
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Gamay"
  },
  #1488
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Laoang"
  },
  #1489
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Lapinig"
  },
  #1490
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Las Navas"
  },
  #1491
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Lavezares"
  },
  #1492
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Lope De Vega"
  },
  #1493
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Mapanas"
  },
  #1494
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Mondragon"
  },
  #1495
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Palapag"
  },
  #1496
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Pambujan"
  },
  #1497
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Rosario"
  },
  #1498
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "San Antonio"
  },
  #1499
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "San Isidro"
  },
  #1500
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "San Jose"
  },
  #1501
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "San Roque"
  },
  #1502
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "San Vicente"
  },
  #1503
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Silvino Lobos"
  },
  #1504
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Northern Samar",
    city_municipal: "Victoria"
  },
  #1505
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Almagro"
  },
  #1506
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Basey"
  },
  #1507
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Calbayog City"
  },
  #1508
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Calbiga"
  },
  #1509
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Catbalogan"
  },
  #1510
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Daram"
  },
  #1511
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Gandara"
  },
  #1512
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Hinabangan"
  },
  #1513
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Jiabong"
  },
  #1514
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Marabut"
  },
  #1515
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Matuguinao"
  },
  #1516
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Motiong"
  },
  #1517
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Pagsanghan"
  },
  #1518
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Paranas (Wright)"
  },
  #1519
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Pinabacdao"
  },
  #1520
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "San Jorge"
  },
  #1521
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "San Jose De Buan"
  },
  #1522
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "San Sebastian"
  },
  #1523
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Santa Margarita"
  },
  #1524
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Santa Rita"
  },
  #1525
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Santo Niño"
  },
  #1526
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Tagapul-An"
  },
  #1527
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Talalora"
  },
  #1528
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Tarangnan"
  },
  #1529
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Villareal"
  },
  #1530
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Samar (Western Samar)",
    city_municipal: "Zumarraga"
  },
  #1531
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Anahawan"
  },
  #1532
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Bontoc"
  },
  #1533
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Hinunangan"
  },
  #1534
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Hinundayan"
  },
  #1535
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Libagon"
  },
  #1536
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Liloan"
  },
  #1537
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Limasawa"
  },
  #1538
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Maasin City"
  },
  #1539
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Macrohon"
  },
  #1540
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Malitbog"
  },
  #1541
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Padre Burgos"
  },
  #1542
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Pintuyan"
  },
  #1543
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Saint Bernard"
  },
  #1544
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "San Francisco"
  },
  #1545
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "San Juan (Cabalian)"
  },
  #1546
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "San Ricardo"
  },
  #1547
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Silago"
  },
  #1548
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Sogod"
  },
  #1549
  %{
    region: "REGION 8",
    region_name: "Eastern Visayas",
    province: "Southern Leyte",
    city_municipal: "Tomas Oppus"
  },
  #1550
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Bacungan (Leon T. Postigo)"
  },
  #1551
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Baliguian"
  },
  #1552
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Dapitan City"
  },
  #1553
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Dipolog City"
  },
  #1554
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Godod"
  },
  #1555
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Gutalac"
  },
  #1556
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Jose Dalman (Ponot)"
  },
  #1557
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Kalawit"
  },
  #1558
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Katipunan"
  },
  #1559
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "La Libertad"
  },
  #1560
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Labason"
  },
  #1561
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Liloy"
  },
  #1562
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Manukan"
  },
  #1563
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Mutia"
  },
  #1564
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Piñan (New Piñan)"
  },
  #1565
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Polanco"
  },
  #1566
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Pres. Manuel A. Roxas"
  },
  #1567
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Rizal"
  },
  #1568
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Salug"
  },
  #1569
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Sergio Osmeña Sr."
  },
  #1570
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Siayan"
  },
  #1571
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Sibuco"
  },
  #1572
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Sibutad"
  },
  #1573
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Sindangan"
  },
  #1574
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Siocon"
  },
  #1575
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Sirawai"
  },
  #1576
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Norte",
    city_municipal: "Tampilisan"
  },
  #1577
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Aurora"
  },
  #1578
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Bayog"
  },
  #1579
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Dimataling"
  },
  #1580
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Dinas"
  },
  #1581
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Dumalinao"
  },
  #1582
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Dumingag"
  },
  #1583
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Guipos"
  },
  #1584
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Isabela City"
  },
  #1585
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Josefina"
  },
  #1586
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Kumalarang"
  },
  #1587
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Labangan"
  },
  #1588
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Lakewood"
  },
  #1589
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Lapuyan"
  },
  #1590
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Mahayag"
  },
  #1591
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Margosatubig"
  },
  #1592
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Midsalip"
  },
  #1593
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Molave"
  },
  #1594
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Pagadian City"
  },
  #1595
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Pitogo"
  },
  #1596
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Ramon Magsaysay (Liargo)"
  },
  #1597
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "San Miguel"
  },
  #1598
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "San Pablo"
  },
  #1599
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Sominot (Don Mariano Marcos)"
  },
  #1600
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Tabina"
  },
  #1601
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Tambulig"
  },
  #1602
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Tigbao"
  },
  #1603
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Tukuran"
  },
  #1604
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Vincenzo A. Sagun"
  },
  #1605
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Del Sur",
    city_municipal: "Zamboanga City"
  },
  #1606
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Alicia"
  },
  #1607
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Buug"
  },
  #1608
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Diplahan"
  },
  #1609
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Imelda"
  },
  #1610
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Ipil"
  },
  #1611
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Kabasalan"
  },
  #1612
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Mabuhay"
  },
  #1613
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Malangas"
  },
  #1614
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Naga"
  },
  #1615
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Olutanga"
  },
  #1616
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Payao"
  },
  #1617
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Roseller Lim"
  },
  #1618
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Siay"
  },
  #1619
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Talusan"
  },
  #1620
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Titay"
  },
  #1621
  %{
    region: "REGION 9",
    region_name: "Zamboanga Peninsula",
    province: "Zamboanga Sibugay",
    city_municipal: "Tungawan"
  }
]

AddressLookUpSeeder.seed(address_look_up_data)

#Creating Address Types
IO.puts "Seeding address types..."
address_type_data = [
  #1
  %{
    code: "P",
    type: "address_type",
    name: "Permanent",
    description: "Permanent"
  },
  #2
  %{
    code: "B",
    type: "address_type",
    name: "Billing",
    description: "Billing"
  }
]
GenericLookUpSeeder.seed(address_type_data)

#Creating VAT Status
IO.puts "Seeding vat statuses..."
vat_status_data = [
  #1
  %{
    code: "20VA",
    type: "vat_status",
    name: "20% VAT-able",
    description: "20% VAT-able"
  },
  #2
  %{
    code: "FV",
    type: "vat_status",
    name: "Fully VAT-able",
    description: "Fully VAT-able"
  },
  #3
  %{
    code: "O",
    type: "vat_status",
    name: "Others",
    description: "Others"
  },
  #4
  %{
    code: "VE",
    type: "vat_status",
    name: "VAT Exempt",
    description: "VAT Exempt"
  },
  #5
  %{
    code: "VA",
    type: "vat_status",
    name: "VAT-able",
    description: "VAT-able"
  },
  #6
  %{
    code: "ZR",
    type: "vat_status",
    name: "Zero-Rated",
    description: "Zero-Rated"
  }
]
GenericLookUpSeeder.seed(vat_status_data)

#Creating Bank Payment Mode
IO.puts "Seeding bank payment modes..."
bank_payment_data = [
  #1
  %{
    code: "C",
    type: "bank_payment_mode",
    name: "Check",
    description: "Check"
  },
  #2
  %{
    code: "ED",
    type: "bank_payment_mode",
    name: "Electronic Debit",
    description: "Electronic Debit"
  }
]
GenericLookUpSeeder.seed(bank_payment_data)

#Creating Account Personnel Payment Modes
IO.puts "Seeding account personnel payment modes..."
account_personnel_payment_mode_data = [
  #1
  %{
    code: "A",
    type: "account_personnel_payment_mode",
    name: "Annual",
    description: "Annual"
  },
  #2
  %{
    code: "D",
    type: "account_personnel_payment_mode",
    name: "Daily",
    description: "Daily"
  },
  #3
  %{
    code: "H",
    type: "account_personnel_payment_mode",
    name: "Hourly",
    description: "Hourly"
  },
  #4
  %{
    code: "M",
    type: "account_personnel_payment_mode",
    name: "Monthly",
    description: "Monthly"
  },
  #5
  %{
    code: "Q",
    type: "account_personnel_payment_mode",
    name: "Quarterly",
    description: "Quarterly"
  },
  #6
  %{
    code: "SA",
    type: "account_personnel_payment_mode",
    name: "Semi-annual",
    description: "Semi-annual"
  },
  #7
  %{
    code: "W",
    type: "account_personnel_payment_mode",
    name: "Weekly",
    description: "Weekly"
  }
]
GenericLookUpSeeder.seed(account_personnel_payment_mode_data)

#Creating Account Contact Type
IO.puts "Seeding account contact types..."
account_contact_type_data = [
  #1
  %{
    code: "CP",
    type: "account_contact_type",
    name: "Contact Person",
    description: "Contact Person"
  },
  #2
  %{
    code: "CS",
    type: "account_contact_type",
    name: "Corp Signatory",
    description: "Corp Signatory"
  },
  #3
  %{
    code: "AM",
    type: "account_contact_type",
    name: "Account Manager",
    description: "Account Manager",
  },
  #4
  %{
    code: "AO",
    type: "account_personnel_payment_mode",
    name: "Account Officer",
    description: "Account Officer"
  },
  #5
  %{
    code: "CC",
    type: "account_personnel_payment_mode",
    name: "Company Contact",
    description: "Company Contact"
  }
]
GenericLookUpSeeder.seed(account_contact_type_data)

#Creating Retainer Fees
IO.puts "Seeding retainer fees..."
retainer_fee_data = [
  #1
  %{
    code: "B",
    type: "retainer_fee",
    name: "Built-in",
    description: "Built-in"
  },
  #2
  %{
    code: "C",
    type: "retainer_fee",
    name: "Charge to ASO",
    description: "Charge to ASO"
  },
  #3
  %{
    code: "S",
    type: "retainer_fee",
    name: "Separate Fee",
    description: "Separate Fee",
  }
]
GenericLookUpSeeder.seed(retainer_fee_data)

IO.puts "Seeding diagnosis..."
diagnosis_data =
  [
    #1
    %{
      code: "A00.0",
      desc: "CHOLERA: Cholera due to Vibrio cholerae 01, biovar cholerae"
    },
    #2
    %{
      code: "A00.1",
      desc: "CHOLERA: Cholera due to Vibrio cholerae 01, biovar eltor"
    },
    #3
    %{
      code: "A01.0",
      desc: "TYPHOID AND PARATYPHOID FEVERS: Typhoid fever"
    },
    #4
    %{
      code: "A01.1",
      desc: "TYPHOID AND PARATYPHOID FEVERS: Paratyphoid fever A"
    },
    #5
    %{
      code: "A01.2",
      desc: "TYPHOID AND PARATYPHOID FEVERS: Paratyphoid fever B"
    },
    #6
    %{
      code: "A01.3",
      desc: "TYPHOID AND PARATYPHOID FEVERS: Paratyphoid fever C"
    },
    #7
    %{
      code: "A01.4",
      desc: "TYPHOID AND PARATYPHOID FEVERS: Paratyphoid fever, unspecified"
    },
    #8
    %{
      code: "A02.0",
      desc: "OTHER SALMONELLA INFECTIONS: Salmonella enteritis"
    },
    #9
    %{
      code: "A02.1",
      desc: "OTHER SALMONELLA INFECTIONS: Salmonella septicaemia"
    },
    #10
    %{
      code: "A02.2",
      desc: "OTHER SALMONELLA INFECTIONS: Localized salmonella infections"
    },
    #11
    %{
      code: "A02.8",
      desc: "OTHER SALMONELLA INFECTIONS: Other specified salmonella infections"
    },
    #12
    %{
      code: "A02.9",
      desc: "OTHER SALMONELLA INFECTIONS: Salmonella infection, unspecified"
    },
    #13
    %{
      code: "A03.0",
      desc: "SHIGELLOSIS: Shigellosis due to Shigella dysenteriae"
    },
    #14
    %{
      code: "A03.1",
      desc: "SHIGELLOSIS: Shigellosis due to Shigella flexneri"
    },
    #15
    %{
      code: "A03.2",
      desc: "SHIGELLOSIS: Shigellosis due to Shigella boydii"
    },
    #16
    %{
      code: "A03.3",
      desc: "SHIGELLOSIS: Shigellosis due to Shigella sonnei"
    },
    #17
    %{
      code: "A03.8",
      desc: "SHIGELLOSIS: Other shigellosis"
    },
    #18
    %{
      code: "A03.9",
      desc: "SHIGELLOSIS: Shigellosis, unspecified"
    },
    #19
    %{
      code: "A04.0",
      desc: "OTHER BACTERIAL INTESTINAL INFECTIONS: Enteropathogenic Escherichia coli infection"
    },
    #20
    %{
      code: "A04.1",
      desc: "OTHER BACTERIAL INTESTINAL INFECTIONS: Enterotoxigenic Escherichia coli infection"
    },
  ]

  [
    di1, di2, di3, di4, di5,
    di6, di7, di8, di9, di10,
    di11, di12, di13, di14, di15,
    di16, di17, di18, di19, di20
  ] = DiagnosisSeeder.seed(diagnosis_data)

#Creating Accounts
IO.puts "Seeding accounts..."
{:ok, effective_date} = Date.new(2011, 1, 1)
{:ok, expiry_date} = Date.new(2050, 1, 1)
account_data = [
  #1
  %{
    name: "MediLink Network Inc.",
    code: "C00001",
    segment: "Corporate",
    effective_date: effective_date,
    expiry_date: expiry_date,
    status: "Active"
  },
  #2
  %{
    name: "Jollibee Worldwide.",
    code: "C00918",
    segment: "Corporate",
    effective_date: effective_date,
    expiry_date: expiry_date,
    status: "Active"
  }
]
[a1, a2] = AccountSeeder.seed(account_data)

#Creating Exclusion

IO.puts "Seeding exclusions..."
exclusion_data = [
  #1
  %{
    code: "Exclusion_1",
    name: "Exclusion_name1",
    type: "General Exclusion",
    classification: "Standard",
    diagnoses: ["CO1", "CO2"],
    procedures: ["CP1", "CP2"],
    policies: ["Policy1"],
    status: "Active",
    version: "1",
    inserted_by: "masteradmin",
    updated_by: "masteradmin"
  },
  #2
  %{
    code: "Exclusion_2",
    name: "Exclusion_name2",
    type: "General Exclusion",
    classification: "Standard",
    diagnoses: ["CO1", "CO2"],
    procedures: ["CP1", "CP2"],
    policies: ["Policy1"],
    status: "Active",
    version: "1",
    inserted_by: "masteradmin",
    updated_by: "masteradmin"
  },
  #3
  %{
    code: "Exclusion_3",
    name: "Exclusion_name3",
    type: "General Exclusion",
    classification: "Standard",
    diagnoses: ["CO1", "CO2"],
    procedures: ["CP1", "CP2"],
    policies: ["Policy1"],
    status: "Active",
    version: "1",
    inserted_by: "masteradmin",
    updated_by: "masteradmin"
  }
]
[ed1, ed2, ed3] = ExclusionSeeder.seed(exclusion_data)

 #Create Procedure
IO.puts "Seeding Procedure ..."
procedure_data =
  [
    %{
      #1
      code: "83498",
      desc: "HYDROXYPROGESTERONE, 17-D",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"

    },
    %{
      #2
      code: "88271",
      desc: "MOLECULAR CYTOGENETICS; DNA PROBE, EACH (EG, FISH)",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #3
      code: "84156",
      desc: "PROTEIN, TOTAL, EXCEPT BY REFRACTOMETRY; URINE",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #4
      code: "82507",
      desc: "CITRATE",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #5
      code: "83497",
      desc: "HYDROXYINDOLACETIC ACID, 5-(HIAA)",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #6
      code: "84060",
      desc: "PHOSPHATASE, ACID; TOTAL",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #7
      code: "82024",
      desc: "ADRENOCORTICOTROPIC HORMONE (ACTH)",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #8
      code: "87015",
      desc: "Concentration (any type), for infectious agents",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #9
      code: "87206",
      desc: "SMEAR, PRIMARY SOURCE WITH INTERPRETATION; FLUORESCENT AND/OR ACID FAST STAIN FOR BACTERIA, FUNGI, PARASITES, VIRUSES OR CELL TYPES",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    },
    %{
      #10
      code: "82042",
      desc: "ALBUMIN; URINE OR OTHER SOURCE, QUANTITATIVE, EACH SPECIMEN",
      type: "CPT",
      standard: "AMA",
      rate_type: "Flat Fee"
    }
  ]

  [
    pr1, pr2, pr3, pr4, pr5,
    pr6, pr7, pr8, pr9, pr10
  ] = ProcedureSeeder.seed(procedure_data)

  #Create Plan
  IO.puts "Seeding Plan ..."
   plan_data =
    [
      %{
        #1
        code: "plan1",
        category: "plan",
        name: "plan1",
        description: "plan1234",
        type: "plan",
        classification: "test",
        applicability: "test1",
        phic_status: "test",
        exclusion_codes: ["1plan"],
        grace_principal_type: "plan",
        grace_principal_value: 10,
        grace_dependent_type: "test",
        grace_dependent_value: 15,
        max_no_dependents: 30,
        default_effective_date: "2019-01-01",
        is_no_outright_denial: true,
        loa_validity: 10,
        application_of_limit: "plan",
        is_sonny_medina: true,
        is_hospital_bill: true,
        is_professional_fee: true,
        principal_schedule: "plan",
        dependent_schedule: "test"

      },
      %{
        #2
        code: "plan12345",
        category: "plan",
        name: "plan12345",
        description: "plan123456",
        type: "plan",
        classification: "test",
        applicability: "test1",
        phic_status: "test",
        exclusion_codes: ["1test"],
        grace_principal_type: "plan",
        grace_principal_value: 10,
        grace_dependent_type: "test",
        grace_dependent_value: 15,
        max_no_dependents: 30,
        default_effective_date: "2019-01-01",
        is_no_outright_denial: true,
        loa_validity: 10,
        application_of_limit: "plan",
        is_sonny_medina: true,
        is_hospital_bill: true,
        is_professional_fee: true,
        principal_schedule: "plan",
        dependent_schedule: "test"

      }
      ]

  [
    pl1, pl2
  ] = PlanSeeder.seed(plan_data)

