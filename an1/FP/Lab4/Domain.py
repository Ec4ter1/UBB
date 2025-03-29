from datetime import date, datetime
def get_number(ap):
    return ap["nr"]
def get_suma_cheltuieli(ap):
    return ap["suma"]
def get_tip_cheltuieli(ap):
    return ap["tip"]
def get_date(ap):
    return ap["data"]
def set_number(ap,nr):
    ap["nr"]=nr
def set_suma_cheltuieli(ap, sum):
    ap["suma"]=sum
def set_tip_cheltuieli(ap, tip):
    ap["tip"]=tip
def set_data(ap,data):
    ap["data"]=datetime.strftime(data,'%d.%m.%Y')

def creare_apart(nr, suma, tip, data):
    """
    Create a new apartment
    :param nr: numarul apartamentului
    :param suma: suma cheltuieli
    :param tip: tipul de cheltuiala
    :param data: data efectuarii cheltuielii
    :return:
    """
    return {"nr": nr, "suma": suma, "tip": tip, "data": data}