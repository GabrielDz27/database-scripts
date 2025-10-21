db.Contas.find().limit(5)

db.Clinetes.findOne()

db.Clientes.find(
    {},
    { nome: 1, genero: 1, _id: 0 }
);

db.Contas.find().skip(10)

db.Contas.find().limit(30).skip(30)

db.Clientes.find().limit(4).sort({ nome: 1 })
db.Clientes.find().limit(4).sort({ nome: -1 })

db.Contas.countDocuments({})

db.Contas.countDocuments({ genero: "Femenino" })

db.Clientes.distinct("profissao")

db.Clientes.find({ genero: { $eq: "Masculino" } })

db.Contas.find({ valor: { $gt: 900 } })

db.Contas.find({ valor: { $lt: 900 } })

db.Clientes.find({ status_civil: { $in: ['Viúvo(a)', 'Casado (a)'] } })

db.Contas.find({ valor: { $gt: 8500, $lt: 9000 } })

db.Clientes.find({ data_nascimento: { $gt: ISODate('1992-01-01') } })

db.Contas.find(
    {
        $and: [
            { tipo: { $eq: "Conta salário" } },
            { valor: { $gt: 9000 } }
        ]
    }
)

db.Clientes.find({ dependentes: { $exists: false } })

db.Clientes.find({ seguros: { $type: 2 } })

db.Clientes.find({ seguros: { $all: ["seguro de vida", "seguro para carro"] } })

db.Clientes.find({ name: { $not: { $eq: /jo/ } } })

db.Clientes.find({ name: /jo/ })
db.Clientes.find({ name: /^jo/ })
db.Clientes.find({ name: /el$/ })

db.clientes.insertOne({
    nome: "Carlos Silva",
    cpf: "12345678900",
    data_nascimento: "1985-10-15",
    profissao: "Professor"
})


db.clientes.insertMany([
    { nome: "Ana Souza", cpf: "23456789011" },
    { nome: "Roberto Lima", cpf: "34567890122" }
])

db.Contas.deleteMany({ saldo: { $lte: 0 } })

db.clientes.updateOne(
    { cpf: "12345678900" },
    { $set: { profissao: "Engenheiro" } }
)

db.Contas.updateOne(
    { cpf: "12345678900" },
    { $inc: { valor: 500 } }
)

db.clientes.replaceOne(
    { _id: ObjectId("66b013fa3a4d9e3abc123456") },
    {
        nome: "João da Silva",
        telefone: "1199999-9999",
        vip: true
    }
)

db.Clientes.aggregate({ $count: "contagem de clientes" })

db.Contas.aggregate({ $group: { _id: "$tipo" } })

db.Contas.aggregate({ $group: { _id: "$tipo", contagem: { $count: {} } } })

db.Contas.aggregate({ $limit: 5 })
db.Contas.aggregate({ $skip: 5 })
db.Contas.aggregate([{ $limit: 10 }, { $skip: 5 }])

db.Contas.aggregate([{ $sort: { valor: -1 } }])

db.Clientes.aggregate([{ $unwind: "$seguros" }, { $limit: 5 }])

db.Clientes.aggregate([{ $unwind: "$seguros" }, { $sortByCount: "$genero" }])

db.Contas.aggregate([
    { $match: { $and: [{ tipo: { $eq: "Conta salário" } }, { valor: { $gt: 3500 } }] } }
])

db.Contas.aggregate([
    {
        $match: {
            $and:
                [{ tipo: { $eq: "Conta salário" } }, {
                    valor: { $gt: 8500 }
                }]
        }
    },
    { $group: { _id: "$tipo", contagem: { $count: {} } } }
])

db.Clientes.aggregate([{
    $lookup: {
            from: "Contas",
            localField: "cpf",
            foreignField: "cpf",
            as: "clientes_contas"
        }
    },
    { $project: { _id: 0, data_nascimento: 0, genero: 0, profissao: 0 } },
    { $limit: 5 }
])

db.Contas.aggregate([
    {
        $group: {
            _id: "$tipo",
            total_arrecadado: { $sum: "$valor" },
            media_valor: { $avg: "$valor" }
        }
    },
    {
        $project: {
            _id: 0, 
            TipoDeConta: "$_id",
            ValorTotal: { $round: ["$total_arrecadado", 2] }, 
            ValorMedio: { $round: ["$media_valor", 2] }
        }
    },
    { $sort: { ValorTotal: -1 } }   
])
