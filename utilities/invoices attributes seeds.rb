Currency.create([
  {
    name: 'Dolar',
    abbreviation: '$'

  },
  {
    name: 'Bolivar Soberano',
    abbreviation: 'Bs'
  }
])

InvoiceFinanceStatus.create([
  {
      name: 'PENDIENTE'
  },
  {
      name: 'PAGADA'
  },
  {
      name: 'ANULADA'
  }
])

InvoiceStatus.create([
  {
    name: 'GENERADA'
  },
  {
    name: 'GUARDADA'
  },
  {
    name: 'CERRADA'
  },
  {
    name: 'FACTURADA'
  }
])

InvoiceItemTax.create([
  {
    name: 'Exento',
    percentage: 0
  },
  {
    name: 'TAX',
    percentage: 7
  },
  {
    name: 'IVA',
    percentage: 16
  },
  {
    name: 'PST',
    percentage: 10
  },
  {
    name: 'PVP',
    percentage: 10
  },
  {
    name: 'GST',
    percentage: 12
  },
  {
    name: 'GST  + PST',
    percentage: 20
  },
  {
    name: 'VAT',
    percentage: 16
  },
])