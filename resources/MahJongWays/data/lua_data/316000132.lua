--[[
		麻將胡了数据脚本, 与老虎机逻辑脚本配合使用
]]---- Ver 0320.1
MahJongWays316000132={
  version = {
    data_type = "HUGA",
    ver = 2,
  },
  is_fa = false,
  bets = {
    bet = {
      3,
      10,
      30,
      90,
    },
    multi = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
    },
    Base = 2000,
  },
  line_coef = 40,
  prize_den = 100,
  tick_range = {
    low = 1,
    high = 1,
  },
  objs = {
    {
      id = 1,
      name = "Wild",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
      },
      scatter = {
        flag = false,
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {
        1,
      },
      line_mutex = {},
      disable_copy = 1,
    },
    {
      id = 2,
      name = "Bonus",
      icon = "",
      k = 1,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = true,
        cont1 = {},
        cont2 = {},
        cont3 = {
          {
            event = 4,
            param = 12,
          },
        },
        cont4 = {
          {
            event = 4,
            param = 14,
          },
        },
        cont5 = {
          {
            event = 4,
            param = 16,
          },
        },
        cont6 = {
          {
            event = 4,
            param = 18,
          },
        },
        cont7 = {
          {
            event = 4,
            param = 20,
          },
        },
        cont8 = {
          {
            event = 4,
            param = 22,
          },
        },
        cont9 = {
          {
            event = 4,
            param = 24,
          },
        },
        cont10 = {
          {
            event = 4,
            param = 26,
          },
        },
        cont11 = {
          {
            event = 4,
            param = 28,
          },
        },
        cont12 = {
          {
            event = 4,
            param = 30,
          },
        },
        cont13 = {
          {
            event = 4,
            param = 32,
          },
        },
        cont14 = {
          {
            event = 4,
            param = 34,
          },
        },
        cont15 = {
          {
            event = 4,
            param = 36,
          },
        },
        cont16 = {
          {
            event = 4,
            param = 38,
          },
        },
        cont17 = {
          {
            event = 4,
            param = 40,
          },
        },
        cont18 = {
          {
            event = 4,
            param = 42,
          },
        },
        cont19 = {
          {
            event = 4,
            param = 44,
          },
        },
        cont20 = {
          {
            event = 4,
            param = 46,
          },
        },
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 1,
    },
    {
      id = 3,
      name = "Green",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 75,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 300,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 500,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 5,
        high = 5,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 1,
    },
    {
      id = 4,
      name = "Red",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 50,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 200,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 400,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 1,
    },
    {
      id = 5,
      name = "Blue",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 40,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 100,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 300,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 1,
    },
    {
      id = 6,
      name = "8W",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 30,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 75,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 200,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 0,
    },
    {
      id = 7,
      name = "5o",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 20,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 50,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 100,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 0,
    },
    {
      id = 8,
      name = "5i",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 20,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 50,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 100,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 0,
    },
    {
      id = 9,
      name = "2o",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 10,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 25,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 50,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 0,
    },
    {
      id = 10,
      name = "2i",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {
        {
          event = 0,
          param = 10,
        },
      },
      cont4 = {
        {
          event = 0,
          param = 25,
        },
      },
      cont5 = {
        {
          event = 0,
          param = 50,
        },
      },
      full = {},
      scatter_cnt = {},
      wild = {},
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      disable_copy = 0,
    },
    {
      id = 11,
      name = "#Green",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        3,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 12,
      name = "#Red",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        4,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 13,
      name = "#Blue",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        5,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 14,
      name = "#8W",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        6,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 15,
      name = "#5o",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        7,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 16,
      name = "#5i",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        8,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 17,
      name = "#2o",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        9,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
    {
      id = 18,
      name = "#2i",
      icon = "",
      k = 100,
      cont2 = {},
      cont3 = {},
      cont4 = {},
      cont5 = {},
      full = {},
      scatter_cnt = {},
      wild = {
        10,
      },
      scatter = {
        flag = false,
        cont1 = {},
        cont2 = {},
        cont3 = {},
        cont4 = {},
        cont5 = {},
      },
      scatter_box = {
        flag = false,
        denominator = 0,
        low = 0,
        high = 0,
      },
      extra_rate = 0,
      mutex = {},
      roll_mutex = {},
      line_mutex = {},
      is_ChangeID = 1,
      disable_copy = 1,
    },
  },
  groups = {},
  prize_multi = {
    1,
    2,
    3,
    5,
  },
  rolls = {
    line_count = 4,
    roll_count = 5,
    rolls = {
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 240,
          cur_total = 440,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 740,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1100,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1700,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2400,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3200,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4100,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5100,
        },
        {
          id = 11,
          drag = 15,
          cur_total = 5115,
        },
        {
          id = 12,
          drag = 20,
          cur_total = 5135,
        },
        {
          id = 13,
          drag = 25,
          cur_total = 5160,
        },
        {
          id = 14,
          drag = 30,
          cur_total = 5190,
        },
        {
          id = 15,
          drag = 35,
          cur_total = 5225,
        },
        {
          id = 16,
          drag = 40,
          cur_total = 5265,
        },
        {
          id = 17,
          drag = 45,
          cur_total = 5310,
        },
        {
          id = 18,
          drag = 50,
          cur_total = 5360,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 2,
          drag = 200,
          cur_total = 200,
        },
        {
          id = 3,
          drag = 250,
          cur_total = 450,
        },
        {
          id = 4,
          drag = 300,
          cur_total = 750,
        },
        {
          id = 5,
          drag = 360,
          cur_total = 1110,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1710,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2410,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3210,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4110,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5110,
        },
      },
    },
  },
  kick_out = {
    multiple = {
      {
        key_val = 1,
        weight = 90,
      },
      {
        key_val = 2,
        weight = 90,
      },
      {
        key_val = 3,
        weight = 90,
      },
      {
        key_val = 4,
        weight = 90,
      },
      {
        key_val = 5,
        weight = 90,
      },
      {
        key_val = 6,
        weight = 90,
      },
    },
    quota = {},
    total = 100,
  },
  uc = {
    uc_type = "UC_MUTEX",
    total = 100,
    rolls = {
      {
        order = 14,
        relation = {
          {
            target = 2,
            weight = 50,
          },
          {
            target = 3,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 75,
        uc = 75,
        total = 155,
      },
      {
        order = 10,
        relation = {},
        columncopy = {},
        uncopy = {},
        cp_numerator = 0,
        col_cp_numerator = 0,
        uc_mutex_numerator = 0,
        uc = 0,
        total = 0,
      },
      {
        order = 12,
        relation = {
          {
            target = 2,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 75,
        uc = 75,
        total = 155,
      },
      {
        order = 16,
        relation = {
          {
            target = 2,
            weight = 33,
          },
          {
            target = 3,
            weight = 33,
          },
          {
            target = 1,
            weight = 33,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 1,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 75,
        uc = 75,
        total = 155,
      },
      {
        order = 24,
        relation = {
          {
            target = 6,
            weight = 50,
          },
          {
            target = 7,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 1,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 75,
        total = 160,
      },
      {
        order = 20,
        relation = {},
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 1,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 75,
        total = 160,
      },
      {
        order = 22,
        relation = {
          {
            target = 6,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 1,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 75,
        total = 160,
      },
      {
        order = 26,
        relation = {
          {
            target = 6,
            weight = 33,
          },
          {
            target = 7,
            weight = 33,
          },
          {
            target = 5,
            weight = 33,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 1,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 75,
        total = 160,
      },
      {
        order = 34,
        relation = {
          {
            target = 2,
            weight = 25,
          },
          {
            target = 3,
            weight = 25,
          },
          {
            target = 1,
            weight = 25,
          },
          {
            target = 4,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 80,
        total = 170,
      },
      {
        order = 30,
        relation = {},
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 0,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 80,
        total = 165,
      },
      {
        order = 32,
        relation = {
          {
            target = 1,
            weight = 25,
          },
          {
            target = 2,
            weight = 25,
          },
          {
            target = 3,
            weight = 25,
          },
          {
            target = 4,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 80,
        total = 170,
      },
      {
        order = 36,
        relation = {
          {
            target = 1,
            weight = 25,
          },
          {
            target = 2,
            weight = 25,
          },
          {
            target = 3,
            weight = 25,
          },
          {
            target = 4,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 80,
        total = 170,
      },
      {
        order = 44,
        relation = {
          {
            target = 5,
            weight = 25,
          },
          {
            target = 6,
            weight = 25,
          },
          {
            target = 7,
            weight = 25,
          },
          {
            target = 8,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 85,
        total = 175,
      },
      {
        order = 40,
        relation = {},
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 0,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 85,
        total = 170,
      },
      {
        order = 42,
        relation = {
          {
            target = 5,
            weight = 25,
          },
          {
            target = 6,
            weight = 25,
          },
          {
            target = 7,
            weight = 25,
          },
          {
            target = 8,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 85,
        total = 175,
      },
      {
        order = 46,
        relation = {
          {
            target = 5,
            weight = 25,
          },
          {
            target = 6,
            weight = 25,
          },
          {
            target = 7,
            weight = 25,
          },
          {
            target = 8,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 85,
        uc = 85,
        total = 175,
      },
      {
        order = 54,
        relation = {
          {
            target = 2,
            weight = 12,
          },
          {
            target = 3,
            weight = 12,
          },
          {
            target = 1,
            weight = 12,
          },
          {
            target = 4,
            weight = 12,
          },
          {
            target = 6,
            weight = 12,
          },
          {
            target = 7,
            weight = 12,
          },
          {
            target = 5,
            weight = 12,
          },
          {
            target = 8,
            weight = 12,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 50,
        relation = {},
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 0,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 180,
      },
      {
        order = 52,
        relation = {
          {
            target = 2,
            weight = 12,
          },
          {
            target = 3,
            weight = 12,
          },
          {
            target = 1,
            weight = 12,
          },
          {
            target = 4,
            weight = 12,
          },
          {
            target = 6,
            weight = 12,
          },
          {
            target = 7,
            weight = 12,
          },
          {
            target = 5,
            weight = 12,
          },
          {
            target = 8,
            weight = 12,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 56,
        relation = {
          {
            target = 2,
            weight = 12,
          },
          {
            target = 3,
            weight = 12,
          },
          {
            target = 1,
            weight = 12,
          },
          {
            target = 4,
            weight = 12,
          },
          {
            target = 6,
            weight = 12,
          },
          {
            target = 7,
            weight = 12,
          },
          {
            target = 5,
            weight = 12,
          },
          {
            target = 8,
            weight = 12,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
    },
    order = {
      2,
      3,
      1,
      4,
      6,
      7,
      5,
      8,
      10,
      11,
      9,
      12,
      14,
      15,
      13,
      16,
      18,
      19,
      17,
      20,
    },
  },
  sa = {
    items = {},
    total = 10,
  },
}
MahJongWays316000132_FreeSpin={
  obj_k = {
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
  },
  prize_multi = {
    2,
    4,
    6,
    10,
  },
  groups = {},
  rolls = {
    line_count = 4,
    roll_count = 5,
    rolls = {
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
        {
          id = 11,
          drag = 25,
          cur_total = 5375,
        },
        {
          id = 12,
          drag = 30,
          cur_total = 5405,
        },
        {
          id = 13,
          drag = 35,
          cur_total = 5440,
        },
        {
          id = 14,
          drag = 40,
          cur_total = 5480,
        },
        {
          id = 15,
          drag = 45,
          cur_total = 5525,
        },
        {
          id = 16,
          drag = 50,
          cur_total = 5575,
        },
        {
          id = 17,
          drag = 55,
          cur_total = 5630,
        },
        {
          id = 18,
          drag = 60,
          cur_total = 5690,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
      {
        {
          id = 1,
          drag = 0,
          cur_total = 0,
        },
        {
          id = 3,
          drag = 400,
          cur_total = 400,
        },
        {
          id = 4,
          drag = 450,
          cur_total = 850,
        },
        {
          id = 5,
          drag = 500,
          cur_total = 1350,
        },
        {
          id = 6,
          drag = 600,
          cur_total = 1950,
        },
        {
          id = 7,
          drag = 700,
          cur_total = 2650,
        },
        {
          id = 8,
          drag = 800,
          cur_total = 3450,
        },
        {
          id = 9,
          drag = 900,
          cur_total = 4350,
        },
        {
          id = 10,
          drag = 1000,
          cur_total = 5350,
        },
      },
    },
  },
  uc = {
    uc_type = "UC_MUTEX",
    total = 100,
    rolls = {
      {
        order = 16,
        relation = {
          {
            target = 4,
            weight = 33,
          },
          {
            target = 3,
            weight = 33,
          },
          {
            target = 2,
            weight = 33,
          },
        },
        columncopy = {},
        uncopy = {},
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 0,
        uc = 100,
        total = 105,
      },
      {
        order = 14,
        relation = {
          {
            target = 4,
            weight = 50,
          },
          {
            target = 3,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {},
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 0,
        uc = 100,
        total = 105,
      },
      {
        order = 12,
        relation = {
          {
            target = 4,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {},
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 0,
        uc = 100,
        total = 105,
      },
      {
        order = 10,
        relation = {},
        columncopy = {},
        uncopy = {},
        cp_numerator = 0,
        col_cp_numerator = 0,
        uc_mutex_numerator = 0,
        uc = 100,
        total = 100,
      },
      {
        order = 20,
        relation = {},
        columncopy = {},
        uncopy = {
          {
            target = 1,
            weight = 0,
          },
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 0,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 85,
        total = 165,
      },
      {
        order = 22,
        relation = {
          {
            target = 5,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 1,
            weight = 0,
          },
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 75,
        uc = 85,
        total = 165,
      },
      {
        order = 24,
        relation = {
          {
            target = 5,
            weight = 50,
          },
          {
            target = 6,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 1,
            weight = 0,
          },
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 85,
        total = 170,
      },
      {
        order = 26,
        relation = {
          {
            target = 5,
            weight = 33,
          },
          {
            target = 6,
            weight = 33,
          },
          {
            target = 7,
            weight = 33,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 1,
            weight = 0,
          },
          {
            target = 2,
            weight = 0,
          },
          {
            target = 3,
            weight = 0,
          },
          {
            target = 4,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 80,
        uc = 85,
        total = 170,
      },
      {
        order = 36,
        relation = {
          {
            target = 12,
            weight = 33,
          },
          {
            target = 11,
            weight = 33,
          },
          {
            target = 10,
            weight = 33,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 34,
        relation = {
          {
            target = 12,
            weight = 50,
          },
          {
            target = 11,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 32,
        relation = {
          {
            target = 12,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 30,
        relation = {
          {
            target = 4,
            weight = 25,
          },
          {
            target = 3,
            weight = 25,
          },
          {
            target = 2,
            weight = 52,
          },
          {
            target = 1,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 5,
            weight = 0,
          },
          {
            target = 6,
            weight = 0,
          },
          {
            target = 7,
            weight = 0,
          },
          {
            target = 8,
            weight = 0,
          },
        },
        cp_numerator = 3,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 183,
      },
      {
        order = 40,
        relation = {
          {
            target = 5,
            weight = 25,
          },
          {
            target = 6,
            weight = 25,
          },
          {
            target = 7,
            weight = 25,
          },
          {
            target = 8,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 3,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 183,
      },
      {
        order = 42,
        relation = {
          {
            target = 13,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 44,
        relation = {
          {
            target = 13,
            weight = 50,
          },
          {
            target = 14,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 46,
        relation = {
          {
            target = 13,
            weight = 33,
          },
          {
            target = 14,
            weight = 33,
          },
          {
            target = 15,
            weight = 33,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 9,
            weight = 0,
          },
          {
            target = 10,
            weight = 0,
          },
          {
            target = 11,
            weight = 0,
          },
          {
            target = 12,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 90,
        uc = 90,
        total = 185,
      },
      {
        order = 56,
        relation = {
          {
            target = 9,
            weight = 25,
          },
          {
            target = 10,
            weight = 25,
          },
          {
            target = 11,
            weight = 25,
          },
          {
            target = 12,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 95,
        uc = 95,
        total = 195,
      },
      {
        order = 54,
        relation = {
          {
            target = 20,
            weight = 50,
          },
          {
            target = 19,
            weight = 50,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 95,
        uc = 95,
        total = 195,
      },
      {
        order = 52,
        relation = {
          {
            target = 20,
            weight = 100,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 5,
        col_cp_numerator = 0,
        uc_mutex_numerator = 95,
        uc = 95,
        total = 195,
      },
      {
        order = 50,
        relation = {
          {
            target = 9,
            weight = 25,
          },
          {
            target = 10,
            weight = 25,
          },
          {
            target = 11,
            weight = 25,
          },
          {
            target = 12,
            weight = 25,
          },
        },
        columncopy = {},
        uncopy = {
          {
            target = 13,
            weight = 0,
          },
          {
            target = 14,
            weight = 0,
          },
          {
            target = 15,
            weight = 0,
          },
          {
            target = 16,
            weight = 0,
          },
        },
        cp_numerator = 3,
        col_cp_numerator = 0,
        uc_mutex_numerator = 95,
        uc = 95,
        total = 193,
      },
    },
    order = {
      4,
      3,
      2,
      1,
      5,
      6,
      7,
      8,
      12,
      11,
      10,
      9,
      13,
      14,
      15,
      16,
      20,
      19,
      18,
      17,
    },
  },
  kick_out = {
    multiple = {
      {
        key_val = 1,
        weight = 95,
      },
      {
        key_val = 2,
        weight = 95,
      },
      {
        key_val = 3,
        weight = 95,
      },
      {
        key_val = 4,
        weight = 95,
      },
      {
        key_val = 5,
        weight = 95,
      },
    },
    quota = {},
    total = 100,
  },
}