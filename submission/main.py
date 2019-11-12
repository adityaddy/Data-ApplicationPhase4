import subprocess as sp
import pymysql
import pymysql.cursors


def adduser():
    
    try:
        row = {}
        print("Enter new user details: ")
        name = (input("Name (Fname Minit Lname): ")).split(' ')
        row["fname"] = name[0]
        row["lname"] = name[1]
        row["fav_drinkname"] = input("fav_drink_name: ")
        row["dob"] = input("Birth Date (YYYY-MM-DD): ")

        query = "INSERT INTO customer(fav_drinkname,dob,fname,lname) VALUES('%s', '%s', '%s', '%s')" %(row['fav_drinkname'],row["dob"],row["fname"], row["lname"])
        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print (">>>>>>>>>>>>>", e)

    return


def deleteuser():

    try:
        cid = int(input("Enter CID of Customer : "))
        query = "SELECT fname FROM customer WHERE cid=%d" %(cid)
        cur.execute(query)
        name = cur.fetchall()
        name = name[0]
        name = name['fname']
        print("First Name of customer to be deleted ",name)
        #delete from from custguard
        try:
            query = "DELETE FROM custguard WHERE cid=%d" %(cid)
            cur.execute(query)
            con.commit()
            print("Deleted customer info from custgaurd table")
        except Exception as e:
            con.rollback()
            print("Failed to delete customer info from custgaurd table")
            print (">>>>>>>>>>>>>", e)
            

        #delete from from drinktrans
        try:
            query = "DELETE FROM drinktrans WHERE cid=%d" %(cid)
            cur.execute(query)
            con.commit()
            print("Deleted customer info from drinktrans table")
        except Exception as e:
            #pass
            con.rollback()
            print("Failed to delete customer info from drinktrans table")
            print (">>>>>>>>>>>>>", e)

        #delete from from lovestogoto
        try:
            query = "DELETE FROM lovestogoto WHERE cid=%d" %(cid)
            cur.execute(query)
            con.commit()
            print("Deleted customer info from lovestogoto table")
        except Exception as e:
            con.rollback()
            print("Failed to delete customer info from lovestogoto table")
            print (">>>>>>>>>>>>>", e)
        #adding in old customer
                #delete from customer table
        try:
            query = "DELETE FROM customer WHERE cid=%d" %(cid)
            cur.execute(query)
            con.commit()
            print("Deleted customer info from customer table")

        except Exception as e:
            #pass
            con.rollback()
            print("Failed to delete customer from customer table")
            print (">>>>>>>>>>>>>", e)
        
        try:
            query = "INSERT INTO oldcust(fname) VALUES('%s')" %(name)
            cur.execute(query)
            con.commit()
            print("Inserted customer into deleted customer table")
        except Exception as e:
            #pass
            con.rollback()
            print("Failed to add customer into old customer table")
            print (">>>>>>>>>>>>>", e)


    except Exception as e:
        con.rollback()
        print("Failed to delete from database")
        print (">>>>>>>>>>>>>", e)

    return



def modifycustomer():
    try:
        cid = int(input("Enter the Customer ID : "))
        field = str(input("Enter the Attribute to modify : "))
        if field=="cid":
            print("Can't Change cid : It is Primary Key")
            return
        value = input("Enter the Attribute Value : ")
        print("field: ",field)
        print("value: ",value)
        query = "UPDATE `customer` SET %s='%s' WHERE cid=%d" %(field,value,cid)
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to Update")
        print (">>>>>>>>>>>>>", e)

    return


def modifybar():
    try:
        bid = input("Enter the Bar ID : ")
        field = input("Enter the Attribute to modify : ")
        if field=="bid":
            print("Can't Change bar id : It is Primary Key")
            return
        value = input("Enter the Attribute Value")
        data = (field, value,bid)
        query = "UPDATE bar SET %s='%s' WHERE cid=%d"
        cur.execute(query,data)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to Update")
        print (">>>>>>>>>>>>>", e)

    return

def modifyBarManager():
    try:
        bid = input("Enter the Bar ID : ")
        field = input("Enter the Attribute to modify : ")
        if field=="bid":
            print("Can't Change bar id : It is Primary Key")
            return
        if field=="name":
            print("Can't Change name : It is Primary Key")
            return
        value = input("Enter the Attribute Value")
        data = (field, value,bid)
        query = "UPDATE bar_manager SET %s=%s WHERE cid=%d"
        cur.execute(query,data)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to Update")
        print (">>>>>>>>>>>>>", e)

    return



def cust_report():
    try:
        query = "SELECT * FROM customer"
        cur.execute(query)
        data = cur.fetchall()
        for x in data:
            print(x)
    except:
        con.rollback()
        print("Failed to Generate report of customers")
        print (">>>>>>>>>>>>>", e)

def bar_report():
    try:
        query = "SELECT * FROM bar"
        cur.execute(query)
        data = cur.fetchall()
        for x in data:
            print(x)
    except:
        con.rollback()
        print("Failed to Generate report of bars")
        print (">>>>>>>>>>>>>", e)

def old_cust_report():
    try:
        query = "SELECT * FROM oldcust"
        cur.execute(query)
        data = cur.fetchall()
        for x in data:
            print(x)
    except:
        con.rollback()
        print("Failed to Generate report of old customers")
        print (">>>>>>>>>>>>>", e)


def callfunc(ch):
    """
    Function that maps helper functions to option entered
    """

    if(ch==1): 
        adduser()
    elif(ch==2):
        deleteuser()
    elif(ch==3):
        modifycustomer()
    elif(ch==4):
        modifybar()
    elif(ch==5):
        modifyBarManager()
    elif(ch==6):
        cust_report()
    elif(ch==7):
        bar_report()
    elif(ch==8):
        old_cust_report()

    else:
        print("Error: Invalid Option")





while(1):
    tmp = sp.call('clear',shell=True)
    username = input("Username: ")
    password = input("Password: ")

    try:
        con = pymysql.connect(host='localhost',
                user=username,
                password=password,
                db='BAR',
                cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear',shell=True)
        with con:
            cur = con.cursor()
            while(1):
                tmp = sp.call('clear',shell=True)
                print("1. Add Customer")
                print("2. Delete Customer")
                print("3. Modify Customer")
                print("4. Modify Bar")
                print("5. Modify Bar Manager")
                print("6. Customer Report")
                print("7. Bar Report")
                print("8. Old Customer Report")
                print("9. Logout")
                ch = int(input("Enter Choice > "))
                tmp = sp.call('clear', shell=True)
                if ch==9:
                    break
                else:
                    callfunc(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except:
        tmp = sp.call('clear',shell=True)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")
