# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Provider.create([
  {
    user_id: User.first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(1).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  }
])

Address.create([
  {
    address: "329 Coventry Road, Libertytown, Wisconsin, 8415",
    latitude: "6.488068",
    longitude: "-66.198274",
    phone: "+1 (852) 454-2034",
    provider_id: Provider.offset(14).first.id,
    category_id: Provider.offset(14).first.categories.first.id
  }
])


Day.create([
  {
    name: "Monday"
  },
  {
    name: "Tuesday"
  },
  {
    name: "Wednesday"
  },
  {
    name: "Thursday"
  },
  {
    name: "Friday"
  },
  {
    name: "Saturday"
  },
  {
    name: "Sunday"
  }
  ])

addresses = Address.all
i = 0
addresses.each do |address|
  i = i+1
  start = Time.at(rand * Time.now.to_i)
  finish = start + 60*60*(1 + (rand 4))
  max_duration = ((finish - start) / 3600).round * 60

  BusinessHour.create([
    {
      address: address,
      hour_start: start.strftime("%H:00:00"),
      hour_finish: finish.strftime("%H:00:00"),
      appointment_duration: (max_duration / (rand 1..(max_duration/20).round)).round,
      name: 'My Custom Appointment Name',
      monday: [true,false].sample,
      tuesday: [true,false].sample,
      wednesday: [true,false].sample,
      thursday: [true,false].sample,
      friday: [true,false].sample,
      saturday: [true,false].sample,
      sunday: [true,false].sample,
    }
  ])

  bh = BusinessHour.find(i)
  BusinessHour.provider_update(bh)

end


AppointmentType.create([
  {
    name: 'Primera Disponible',
    priority: 3
  },
  {
    name: 'Intervalo de Fechas',
    priority: 2
  },
  {
    name: 'Especial',
    priority: 1
  }
  ])

  AuthClient.create([
    {
      uid: '2ab480b7a5197b2f88fb66048cd24d89dc59ad6b5ab086f11befb80bf23ae109',
      name: 'React Native iOS'
    }
    ])

  NotificationType.create([
    {
      name: 'Appointment Accepted'
    },
    {
      name: 'Appointment Canceled'
    },
    {
      name: 'Appointment Confirmed'
    },
    {
      name: 'Appointment Requested'
    },
    {
      name: 'Recommendation'
    },
    {
      name: 'Calification'
    },
    {
      name: 'Appointment Reminder'
    },
    ])
