# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([
  {
    name: "Aromaterapia",
    description: "Terapia de olores",
    photo_url: 'aromaterapia.png'
  },
  {
    name: "Fisioterapia",
    description: "Terapia del Movimiento",
    photo_url: 'fisioterapia.png'

  },
  {
    name: "Oftalmologia",
    description: "Servicios de la vista",
    photo_url: 'oftalmologia.png'
  },
  {
      name: "Salud dental",
      description: "Servicios dentales y bucales",
      photo_url: 'saluddental.png'
    },
  {
      name: "Ginecologia",
      description: "Diagnostico, control y tratamiento para la mujer",
      photo_url: 'ginecologia.png'
    },
  {
      name: "Cardiologia",
      description: "Tratamientos y diagnosticos para el corazon",
      photo_url: 'cardiologia.png'
    },
  {
    name: "ex",
    description: "Do voluptate commodo veniam cupidatat.",
    photo_url: 'default.png'
  },
  {
    name: "velit",
    description: "Sit labore tempor consequat aliqua occaecat.",
    photo_url: 'default.png'
  },
  {
    name: "nulla",
    description: "Irure Lorem officia anim exercitation exercitation adipisicing non minim sunt ea et in.",
    photo_url: 'default.png'
  },
  {
    name: "laborum",
    description: "Est labore adipisicing labore sint ipsum labore irure Lorem cupidatat.",
    photo_url: 'default.png'
  },
  {
    name: "magna",
    description: "Irure tempor commodo ea voluptate aute quis esse cupidatat exercitation.",
    photo_url: 'default.png'
  },
  {
    name: "mollit",
    description: "Incididunt cillum deserunt quis ad aute do laboris sit aliqua pariatur aute duis magna.",
    photo_url: 'default.png'
  },
  {
    name: "eu",
    description: "Occaecat fugiat eu ullamco ea cillum.",
    photo_url: 'default.png'
  },
  {
    name: "exercitation",
    description: "Irure pariatur minim sunt ut anim sunt magna mollit sint incididunt dolor elit.",
    photo_url: 'default.png'
  },
  {
    name: "excepteur",
    description: "Eu magna voluptate aliquip est deserunt culpa dolore dolore laboris nisi eiusmod.",
    photo_url: 'default.png'
  },
  {
    name: "dolor",
    description: "Minim elit ex excepteur enim non.",
    photo_url: 'default.png'
  },
  {
    name: "aliqua",
    description: "Officia ea duis aute sint sunt labore nisi enim in consectetur ad do qui ut.",
    photo_url: 'default.png'
  },
  {
    name: "deserunt",
    description: "Pariatur duis irure dolore commodo aliquip minim eu reprehenderit sunt nulla dolor ex id quis.",
    photo_url: 'default.png'
  },
  {
    name: "ipsum",
    description: "Duis aliquip mollit sint occaecat cupidatat.",
    photo_url: 'default.png'
  },
  {
    name: "cillum",
    description: "Sint do adipisicing voluptate cillum commodo elit elit amet exercitation.",
    photo_url: 'default.png'
  },
  {
    name: "ullamco",
    description: "Proident labore sit laboris laborum consectetur reprehenderit et ad nisi id aute aute veniam.",
    photo_url: 'default.png'
  },
  {
    name: "veniam",
    description: "Elit excepteur sit consequat consectetur aliqua mollit esse voluptate ex exercitation.",
    photo_url: 'default.png'
  },
  {
    name: "sint",
    description: "Adipisicing commodo exercitation pariatur elit sunt quis.",
    photo_url: 'default.png'
  },
  {
    name: "minim",
    description: "Exercitation deserunt pariatur et magna dolore duis est magna duis eu.",
    photo_url: 'default.png'
  },
  {
    name: "voluptate",
    description: "Non consequat reprehenderit excepteur aute ipsum veniam pariatur elit nisi sit aliqua excepteur.",
    photo_url: 'default.png'
  },
  {
    name: "commodo",
    description: "Non velit ea ex veniam magna nostrud esse.",
    photo_url: 'default.png'
  },
  {
    name: "do",
    description: "Laborum commodo dolor laborum magna esse duis duis.",
    photo_url: 'default.png'
  },
  {
    name: "est",
    description: "Fugiat sit ex ad tempor laborum.",
    photo_url: 'default.png'
  },
  {
    name: "non",
    description: "Cupidatat aliquip proident sint pariatur veniam qui consectetur ut ea sint eu anim qui veniam.",
    photo_url: 'default.png'
  },
  {
    name: "esse",
    description: "Voluptate elit enim occaecat elit voluptate quis cillum amet nisi adipisicing.",
    photo_url: 'default.png'
  },
  {
    name: "sunt",
    description: "Deserunt sit aliquip quis fugiat labore anim exercitation commodo anim.",
    photo_url: 'default.png'
  },
  {
    name: "nisi",
    description: "Ipsum anim commodo tempor pariatur proident nulla cillum deserunt sint.",
    photo_url: 'default.png'
  },
  {
    name: "Lorem",
    description: "Officia adipisicing laborum consequat culpa id adipisicing veniam nostrud sint labore id nostrud pariatur ipsum.",
    photo_url: 'default.png'
  }
])

Service.create([
  {
    name: "servicios medicos",
    description: "Doctores y cosas por el estilo",
    photo_url: 'serviciosmedicos.png'
  },
  {
    name: "restaurantes",
    description: "Lugares donde Comer",
    photo_url: 'restaurantes.png'

  },
  {
    name: "transporte ejecutivo",
    description: "servicios de transporte a la medida",
    photo_url: 'transporteejecutivo.png'
  },
  {
      name: "vacacionales",
      description: "Lugares de relajacion, puro lujo",
      photo_url: 'vacacionales.png'
    },
  {
      name: "servicios de autos",
      description: "donde reparar y hacer mantenimiento a su vehiculo",
      photo_url: 'serviciosdeautos.png'
    },
  {
      name: "spa y estetica",
      description: "todo para rejuvenecer tu cuerpo",
      photo_url: 'spayestetica.png'
    }
])

CategoryService.create([
  {
    service_id: 1,
    category_id: 1
  },
  {
    service_id: 2,
    category_id: 2
  },
  {
    service_id: 3,
    category_id: 3
  },
  {
    service_id: 4,
    category_id: 4
  },
  {
    service_id: 5,
    category_id: 5
  },
  {
    service_id: 6,
    category_id: 6
  },
  {
    service_id: 1,
    category_id: 7
  },
  {
    service_id: 2,
    category_id: 8
  },
  {
    service_id: 3,
    category_id: 9
  },
  {
    service_id: 4,
    category_id: 9
  },
  {
    service_id: 5,
    category_id: 10
  },
  {
    service_id: 6,
    category_id: 11
  },
  {
    service_id: 1,
    category_id: 12
  },

  {
    service_id: 1,
    category_id: 2
  },
  {
    service_id: 1,
    category_id: 16
  },
  {
    service_id: 3,
    category_id: 17
  },
  {
    service_id: 4,
    category_id: 19
  },
  {
    service_id: 5,
    category_id: 20
  },
  {
    service_id: 6,
    category_id: 22
  }
])

User.create([
  {
    name: "Leigh Ramirez",
    email: "leigh.ramirez@email.com",
    api_token: "57fbb07da51beb08f3e4aefc",
    password_digest: User.digest('leigh')
  },
  {
    name: "Reeves Lamb",
    email: "reeves.lamb@email.com",
    api_token: "57fbb07d57362c26129b6728",
    password_digest: User.digest('reeves')
  },
  {
    name: "Corina Bowers",
    email: "corina.bowers@email.com",
    api_token: "57fbb07d3a87282069a3ddff",
    password_digest: User.digest('corina')
  },
  {
    name: "Battle Ellis",
    email: "battle.ellis@email.com",
    api_token: "57fbb07d60d4817371398f8c",
    password_digest: User.digest('battle')
  },
  {
    name: "Katie Ashley",
    email: "katie.ashley@email.com",
    api_token: "57fbb07df25a81ebca5cadbf",
    password_digest: User.digest('katie')
  },
  {
    name: "Huff Myers",
    email: "huff.myers@email.com",
    api_token: "57fbb07d223315fcc00e9914",
    password_digest: User.digest('huff')
  },
  {
    name: "Wooten Fitzpatrick",
    email: "wooten.fitzpatrick@email.com",
    api_token: "57fbb07dafb59a7897b4b1a3",
    password_digest: User.digest('wooten')
  },
  {
    name: "Suzette Sanders",
    email: "suzette.sanders@email.com",
    api_token: "57fbb07d0e6f33714df98cba",
    password_digest: User.digest('suzette')
  },
  {
    name: "Huffman Walls",
    email: "huffman.walls@email.com",
    api_token: "57fbb07d100dc2fd0cd94098",
    password_digest: User.digest('huffman')
  },
  {
    name: "Washington Browning",
    email: "washington.browning@email.com",
    api_token: "57fbb07d882ddf0ee1c6e1e7",
    password_digest: User.digest('washington')
  },
  {
    name: "Travis Camacho",
    email: "travis.camacho@email.com",
    api_token: "57fbb07d7cbd79349b9def7a",
    password_digest: User.digest('travis')
  },
  {
    name: "Sargent Acosta",
    email: "sargent.acosta@email.com",
    api_token: "57fbb07d4cbb7b1357a84bc0",
    password_digest: User.digest('sargent')
  },
  {
    name: "Melba Petersen",
    email: "melba.petersen@email.com",
    api_token: "57fbb07da7e87cda2cd40a42",
    password_digest: User.digest('melba')
  },
  {
    name: "Goodman Jacobs",
    email: "goodman.jacobs@email.com",
    api_token: "57fbb07d31260659e9cc42da",
    password_digest: User.digest('goodman')
  },
  {
    name: "Rhonda Callahan",
    email: "rhonda.callahan@email.com",
    api_token: "57fbb07d16e67ec61d4b1ea8",
    password_digest: User.digest('rhonda')
  },
  {
    name: "Carlene Melton",
    email: "carlene.melton@email.com",
    api_token: "57fbb07dbc1b798b71c655c2",
    password_digest: User.digest('carlene')
  },
  {
    name: "Jefferson Berger",
    email: "jefferson.berger@email.com",
    api_token: "57fbb07df1c61a3673ecfbd3",
    password_digest: User.digest('jefferson')
  },
  {
    name: "Beryl Holman",
    email: "beryl.holman@email.com",
    api_token: "57fbb07d2530c6c9839cfef0",
    password_digest: User.digest('beryl')
  },
  {
    name: "Curtis Peterson",
    email: "curtis.peterson@email.com",
    api_token: "57fbb07df0590addc13a7b22",
    password_digest: User.digest('curtis')
  },
  {
    name: "Mayra Roberson",
    email: "mayra.roberson@email.com",
    api_token: "57fbb07debcb3501a9fa7e0f",
    password_digest: User.digest('mayra')
  }
])

Customer.create([
  {
    address: "638 Bancroft Place, Stagecoach, Pennsylvania, 8750, Banco Central",
    latitude: "10.508296",
    longitude: "-66.915520",
    phone: "+1 (941) 446-3215",
    user_id: User.offset(15).first.id
  },
  {
    address: "476 Tehama Street, Dawn, Mississippi, 3727, Palacio de Justicia",
    latitude: "10.501760",
    longitude: "-66.913273",
    phone: "+1 (894) 411-3040",
    user_id: User.offset(16).first.id
  },
  {
    address: "961 Bliss Terrace, Vallonia, Nebraska, 9482, Fuerte Tiuna",
    latitude: "10.472525",
    longitude: "-66.896891",
    phone: "+1 (931) 477-2312",
    user_id: User.offset(17).first.id
  },
  {
    address: "424 Oxford Walk, Sussex, Rhode Island, 4927, Ciudad Universitaria",
    latitude: "10.486647",
    longitude: "-66.892895",
    phone: "+1 (838) 505-3162",
    user_id: User.offset(18).first.id
  },
  {
    address: "368 Garden Place, Ventress, Guam, 2721, Plaza Francia",
    latitude: "10.496777",
    longitude: "-66.849081",
    phone: "+1 (943) 437-2447",
    user_id: User.offset(19).first.id
  },
  {
    address: "368 Garden Place, Ventress, Guam, 2721, Parque del Este",
    latitude: "10.494675",
    longitude: "-66.840507",
    phone: "+1 (943) 437-2447",
    user_id: User.first.id
  }
  # {
  #   address: "424 Oxford Walk, Sussex, Rhode Island, 4927, Los Caobos",
  #   latitude: "10.500662",
  #   longitude: "-66.884449",
  #   phone: "+1 (696) 505-9985",
  #   user_id: User.offset(20).first.id
  # },
  # {
  #   address: "889 Oxford Walk, Sussex, Rhode Island, 4927, Av. Diego Lozada '12 de febrero'",
  #   latitude: "10.514187",
  #   longitude: "-66.893399",
  #   phone: "+1 (852) 501-1244",
  #   user_id: User.offset(21).first.id
  # },
  # {
  #   address: "211 Tehama Street, Dawn, Mississippi, 3727, YNCA San Bernardino",
  #   latitude: "10.510426",
  #   longitude: "-66.897134",
  #   phone: "+1 (415) 663-2062",
  #   user_id: User.offset(12).first.id
  # }
])

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
  },
  {
    user_id: User.offset(2).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(3).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(4).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(5).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(6).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(7).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(8).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(9).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(10).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(11).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(12).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(13).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  },
  {
    user_id: User.offset(14).first.id,
    categories: Category.order("RAND()").take(2),
    profile_link: 'http://www.example.org/'
  }
])

Address.create([
  {
    address: "638 Bancroft Place, Stagecoach, Pennsylvania, 8750, Banco Central",
    latitude: "10.508296",
    longitude: "-66.915520",
    phone: "+1 (934) 501-2627",
    provider_id: Provider.first.id,
    category_id: Provider.first.categories.first.id,
  },
  {
    address: "476 Tehama Street, Dawn, Mississippi, 3727, Palacio de Justicia",
    latitude: "10.501760",
    longitude: "-66.913273",
    phone: "+1 (966) 575-3355",
    provider_id: Provider.offset(1).first.id,
    category_id: Provider.offset(1).first.categories.first.id
  },
  {
    address: "961 Bliss Terrace, Vallonia, Nebraska, 9482, Fuerte Tiuna",
    latitude: "10.472525",
    longitude: "-66.896891",
    phone: "+1 (947) 596-3222",
    provider_id: Provider.offset(2).first.id,
    category_id: Provider.offset(2).first.categories.first.id
  },
  {
    address: "424 Oxford Walk, Sussex, Rhode Island, 4927, Ciudad Universitaria",
    latitude: "10.486647",
    longitude: "-66.892895",
    phone: "+1 (973) 572-3502",
    provider_id: Provider.offset(3).first.id,
    category_id: Provider.offset(3).first.categories.first.id
  },
  {
    address: "368 Garden Place, Ventress, Guam, 2721, Plaza Francia",
    latitude: "10.496777",
    longitude: "-66.849081",
    phone: "+1 (917) 433-2142",
    provider_id: Provider.offset(4).first.id,
    category_id: Provider.offset(4).first.categories.first.id
  },
  {
    address: "368 Garden Place, Ventress, Guam, 2721, Parque del Este",
    latitude: "10.494675",
    longitude: "-66.840507",
    phone: "+1 (832) 501-3039",
    provider_id: Provider.offset(5).first.id,
    category_id: Provider.offset(5).first.categories.first.id
  },
  {
    address: "772 Moffat Street, Sterling, Nevada, 1387",
    latitude: "-27.874284",
    longitude: "91.071915",
    phone: "+1 (843) 426-3962",
    provider_id: Provider.offset(6).first.id,
    category_id: Provider.offset(6).first.categories.first.id
  },
  {
    address: "807 Harrison Place, Independence, Tennessee, 1237",
    latitude: "76.743225",
    longitude: "-126.256613",
    phone: "+1 (998) 499-3278",
    provider_id: Provider.offset(7).first.id,
    category_id: Provider.offset(7).first.categories.first.id
  },
  {
    address: "941 Strong Place, Movico, Minnesota, 5752",
    latitude: "21.373745",
    longitude: "-112.474879",
    phone: "+1 (895) 483-3763",
    provider_id: Provider.offset(8).first.id,
    category_id: Provider.offset(8).first.categories.first.id
  },
  {
    address: "481 Irving Street, Diaperville, South Dakota, 4206",
    latitude: "88.71198",
    longitude: "-54.995922",
    phone: "+1 (838) 413-3435",
    provider_id: Provider.offset(9).first.id,
    category_id: Provider.offset(9).first.categories.first.id
  },
  {
    address: "929 Frank Court, Allamuchy, Kentucky, 5593",
    latitude: "12.797388",
    longitude: "70.21059",
    phone: "+1 (861) 580-3005",
    provider_id: Provider.offset(10).first.id,
    category_id: Provider.offset(10).first.categories.first.id
  },
  {
    address: "764 Love Lane, Cuylerville, Missouri, 8327",
    latitude: "-69.076142",
    longitude: "-67.747194",
    phone: "+1 (903) 400-3266",
    provider_id: Provider.offset(11).first.id,
    category_id: Provider.offset(11).first.categories.first.id
  },
  {
    address: "505 Colonial Court, Freetown, Idaho, 9897",
    latitude: "-66.384229",
    longitude: "37.222826",
    phone: "+1 (969) 480-2183",
    provider_id: Provider.offset(12).first.id,
    category_id: Provider.offset(12).first.categories.first.id
  },
  {
    address: "209 Roosevelt Court, Montura, Colorado, 4583",
    latitude: "-45.508483",
    longitude: "5.415746",
    phone: "+1 (842) 569-3184",
    provider_id: Provider.offset(13).first.id,
    category_id: Provider.offset(13).first.categories.first.id
  },
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

AppointmentStatus.create([
  {
    name: 'Pending'
  },
  {
    name: 'Approved'
  },
  {
    name: 'Confirmed'
  },
  {
    name: 'Canceled'
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
