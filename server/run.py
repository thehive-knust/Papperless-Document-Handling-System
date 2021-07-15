from pdhs_app import create_app

app = create_app(env='testing')

if __name__ == '__main__':
    app.run()
