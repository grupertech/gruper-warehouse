User.create([
  {name: 'Admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password', role: 'admin'}
])

Tax.create([
  {name: 'PPN', rate: 10, created_by: 'Admin'}
])

Category.create([
  {name: 'Elektronik', created_by: 'Admin'},
  {name: 'Fashion Anak', created_by: 'Admin'},
  {name: 'Fashion Pria', created_by: 'Admin'},
  {name: 'Fashion Wanita', created_by: 'Admin'},
  {name: 'Food', created_by: 'Admin'},
  {name: 'Handphone', created_by: 'Admin'}
])

PaymentType.create(
  [
    {name: 'Bank Transfer', created_by: 'Admin'},
    {name: 'Check', created_by: 'Admin'},
    {name: 'Cash', created_by: 'Admin'}
  ]
)

Brand.create(
  [
    {name: 'Adidas', created_by: 'Admin'},
    {name: 'Apple', created_by: 'Admin'},
    {name: 'Asus', created_by: 'Admin'},
    {name: 'Lenovo', created_by: 'Admin'},
    {name: 'Xiaomi', created_by: 'Admin'}
  ]
)

Courier.create(
  [
    {code: 'JNE', name: 'JNE', created_by: 'Admin'},
    {code: 'J&T', name: 'J&T', created_by: 'Admin'},
    {code: 'TKI', name: 'Tiki', created_by: 'Admin'},
    {code: 'GSN', name: 'Go-Send', created_by: 'Admin'}
  ]
)

Unit.create(
  [
    {name: 'Kg', created_by: 'Admin'},
    {name: 'Gram', created_by: 'Admin'},
  ]
)

Customer.create([
  {name: 'Customer 1', email: 'customer1@email.com', company: 'Company 1', phone_number: '0888833311', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Customer 2', email: 'customer2@email.com', company: 'Company 2', phone_number: '0888833312', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Customer 3', email: 'customer3@email.com', company: 'Company 3', phone_number: '0888833313', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Customer 4', email: 'customer4@email.com', company: 'Company 4', phone_number: '0888833314', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Customer 5', email: 'customer5@email.com', company: 'Company 5', phone_number: '0888833315', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Customer 6', email: 'customer6@email.com', company: 'Company 6', phone_number: '0888833316', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
])

Vendor.create([
  {name: 'Vendor 1', email: 'vendor1@email.com', company: 'Vendor 1', phone_number: '0888833311', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Vendor 2', email: 'vendor2@email.com', company: 'Vendor 2', phone_number: '0888833312', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Vendor 3', email: 'vendor3@email.com', company: 'Vendor 3', phone_number: '0888833313', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Vendor 4', email: 'vendor4@email.com', company: 'Vendor 4', phone_number: '0888833314', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Vendor 5', email: 'vendor5@email.com', company: 'Vendor 5', phone_number: '0888833315', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
  {name: 'Vendor 6', email: 'vendor6@email.com', company: 'Vendor 6', phone_number: '0888833316', address: 'Some address', country: 'Indonesia', created_by: 'Admin'},
])

3.times do 
  event = Event.new
  event.title = Faker::Book.title
  start = Faker::Time.between(Date.today, Date.today, :morning)
  event.start_event = start
  event.end_event = Faker::Time.between(start, start + 2.days, :evening)
  event.color = ['black','green','red', nil].sample
  event.save
end

CompanyInfo.create(
  name_company: 'Your Company Name',
  npwp: '',
  website: 'http://google.com',
  address: 'Jl Mentimun 4',
  city: 'Tangerang',
  province: 'Banten',
  postal_code: '15560',
  country: 'Indonesia',
  name_person: 'John',
  phone_one: '08123456789',
  phone_two: '08213456789',
  email: 'john@gmail.com',
  fax: '(021) 59792259',
  created_by: 'Admin'
)