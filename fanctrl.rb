# Each line: [ temp C, fan speed % ]
CURVE = [
  [0, 0],
  [10, 0],
  [30, 5],
  [40, 10],
  [50, 30],
  [70, 60],
  [80, 100]
]

MANUAL_CUTOFF = 65  # When to disable OS fan control

DT = 5              # Check every DT seconds

def get_avg_temp
  `sensors -u`.scan(/temp[0-9]+_input:\s([0-9.]+)/).flatten.map(&:to_f).instance_eval { reduce(:+) / size.to_f }
end

def get_fan_speed temp
  i = 0
  power = 100
  while i < (CURVE.size - 1) do
    a = CURVE[i]
    b = CURVE[i + 1]

    if temp >= a[0] && temp <= b[0]
      power = a[1] + (temp - a[0]) * (b[1] - a[1]) / (b[0] - a[0])
      break
    end

    i += 1
  end

  power
end

def set_fan_speed speed
  `ipmitool raw 0x30 0x30 0x02 0xff 0x#{speed.to_i.to_s(16)}`
end

def set_manual_fan_ctrl enable
  `ipmitool raw 0x30 0x30 0x01 #{enable ? "0x00" : "0x01"}`
end

loop do
  temp = get_avg_temp
  manual = temp < MANUAL_CUTOFF
  fan_speed = get_fan_speed temp

  puts "Temp: #{temp}C -> #{manual ? "Fans: #{fan_speed}%" : "Dell Automated Fan Speed (manual cutoff = #{MANUAL_CUTOFF})"}"

  set_manual_fan_ctrl manual
  set_fan_speed(fan_speed) if manual

  sleep DT
end
