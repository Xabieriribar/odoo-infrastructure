{
    'name': "Mela Bike Management",
    'summary': "Manage bike rentals and repairs",
    'description': """
        Custom module for Mela Bike.
        Compliant with Odoo 17 and Dockerized Infrastructure.
    """,
    'author': "Mela Bike Dev Team",
    'website': "https://staging.mela.bike",
    'category': 'Services',
    'version': '17.0.1.0.0',
    'depends': ['base', 'sale', 'stock'],
    'data': [
        # 'security/ir.model.access.csv',
        # 'views/views.xml',
    ],
    'installable': True,
    'application': True,
    'license': 'LGPL-3',
}
