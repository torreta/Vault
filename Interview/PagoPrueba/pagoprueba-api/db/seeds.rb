# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bank_list = [
  ["Banco Central de Venezuela","0001"]
  ["Banco Industrial de Venezuela, C.A. Banco Universal","0003"]
  ["Banco de Venezuela S.A.C.A. Banco Universal","0102"]
  ["Venezolano de Crédito, S.A. Banco Universal","0104"]
  ["Banco Mercantil, C.A S.A.C.A. Banco Universal","0105"]
  ["Banco Provincial, S.A. Banco Universal","0108"]
  ["Bancaribe C.A. Banco Universal","0114"]
  ["Banco Exterior C.A. Banco Universal","0115"]
  ["Banco Occidental de Descuento, Banco Universal C.A.","0116"]
  ["Banco Caroní C.A. Banco Universal","0128"]
  ["Banesco Banco Universal S.A.C.A.","0134"]
  ["Banco Sofitasa Banco Universal","0137"]
  ["Banco Plaza Banco Universal","0138"]
  ["Banco de la Gente Emprendedora C.A.","0146"]
  ["Banco del Pueblo Soberano, C.A. Banco de Desarrollo","0149"]
  ["BFC Banco Fondo Común C.A Banco Universal","0151"]
  ["100% Banco, Banco Universal C.A.","0156"]
  ["DelSur Banco Universal, C.A.","0157"]
  ["Banco del Tesoro, C.A. Banco Universal","0163"]
  ["Banco Agrícola de Venezuela, C.A. Banco Universal","0166"]
  ["Bancrecer, S.A. Banco Microfinanciero","0168"]
  ["Mi Banco Banco Microfinanciero C.A.","0169"]
  ["Banco Activo, C.A. Banco Universal","0171"]
  ["Bancamiga Banco Microfinanciero C.A.","0172"]
  ["Banco Internacional de Desarrollo, C.A. Banco Universal","0173"]
  ["Banplus Banco Universal, C.A.","0174"]
  ["Banco Bicentenario Banco Universal C.A.","0175"]
  ["Banco Espirito Santo, S.A. Sucursal Venezuela B.U.","0176"]
  ["Banco de la Fuerza Armada Nacional Bolivariana, B.U.","0177"]
  ["Citibank N.A.","0190"]
  ["Banco Nacional de Crédito, C.A. Banco Universal","0191"]
  ["Instituto Municipal de Crédito Popular","0601"]
]

bank_list.each do |name, code3, code2|
  Banks.create( name: name, code: code3)
end