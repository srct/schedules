// To parse this data:
//
//   import { Convert } from "./file";
//
//   const section = Convert.toSection(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface Section {
    id:           number;
    name:         string;
    crn:          string;
    section_type: string;
    title:        string;
    instructor:   string;
    start_date:   string;
    end_date:     string;
    days:         string;
    start_time:   string;
    end_time:     string;
    location:     string;
    status?:      string;
    campus?:      string;
    notes?:       string;
    size_limit?:  number;
    course_id:    number;
    created_at:   string;
    updated_at:   string;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export namespace Convert {
    export function toSection(json: string): Section[] {
        return cast(JSON.parse(json), a(r("Section")));
    }

    export function sectionToJson(value: Section[]): string {
        return JSON.stringify(value, null, 2);
    }

    function cast<T>(obj: any, typ: any): T {
        if (!isValid(typ, obj)) {
            throw Error(`Invalid value`);
        }
        return obj;
    }

    function isValid(typ: any, val: any): boolean {
        if (typ === "any") { return true; }
        if (typ === null) { return val === null; }
        if (typ === false) { return false; }
        while (typeof typ === "object" && typ.ref !== undefined) {
            typ = typeMap[typ.ref];
        }
        if (Array.isArray(typ)) { return isValidEnum(typ, val); }
        if (typeof typ === "object") {
            return typ.hasOwnProperty("unionMembers") ? isValidUnion(typ.unionMembers, val)
                : typ.hasOwnProperty("arrayItems")    ? isValidArray(typ.arrayItems, val)
                : typ.hasOwnProperty("props")         ? isValidObject(typ.props, typ.additional, val)
                : false;
        }
        return isValidPrimitive(typ, val);
    }

    function isValidPrimitive(typ: string, val: any) {
        return typeof typ === typeof val;
    }

    function isValidUnion(typs: any[], val: any): boolean {
        // val must validate against one typ in typs
        return typs.some((typ) => isValid(typ, val));
    }

    function isValidEnum(cases: string[], val: any): boolean {
        return cases.indexOf(val) !== -1;
    }

    function isValidArray(typ: any, val: any): boolean {
        // val must be an array with no invalid elements
        return Array.isArray(val) && val.every((element) => {
            return isValid(typ, element);
        });
    }

    function isValidObject(props: { [k: string]: any }, additional: any, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return false;
        }
        return Object.getOwnPropertyNames(val).every((key) => {
            const prop = val[key];
            if (Object.prototype.hasOwnProperty.call(props, key)) {
                return isValid(props[key], prop);
            }
            return isValid(additional, prop);
        });
    }

    function a(typ: any) {
        return { arrayItems: typ };
    }

    function u(...typs: any[]) {
        return { unionMembers: typs };
    }

    function o(props: { [k: string]: any }, additional: any) {
        return { props, additional };
    }

    function m(additional: any) {
        return { props: {}, additional };
    }

    function r(name: string) {
        return { ref: name };
    }

    const typeMap: any = {
        "Section": o({
            id: 0,
            name: "",
            crn: "",
            section_type: "",
            title: "",
            instructor: "",
            start_date: "",
            end_date: "",
            days: "",
            start_time: "",
            end_time: "",
            location: "",
            status: "",
            campus: "",
            notes: "",
            size_limit: 0,
            course_id: 0,
            created_at: "",
            updated_at: "",
        }, false),
    };
}
